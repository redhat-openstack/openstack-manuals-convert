#!/bin/sh

#################
# INITIAL SETUP #
#################

# TODO: xml-commons-resolver
# https://bugzilla.redhat.com/show_bug.cgi?id=955692

XSLT_PROC=`which saxon`

# Location of XSLT to be used in transforms.
CONF_DIR="/home/sgordon/Source/publizanize/etc"
XSLT_DIR="/home/sgordon/Source/publicanize/xsl"
XML_DIR="/home/sgordon/Source/publicanize/xml"
CFG_DIR="/home/sgordon/Source/publicanize/cfg"
TOP_DIR=`pwd`

# xsltproc executable must be available.
if [ -z ${XSLT_PROC} ]; then
    echo "Error: No saxon binary found. Install the saxon package." 1>&2
    exit 1
fi

# We need publican.cfg to extract firstname, surname, email from. These are
# mandatory in the revision history.
if [ ! -f ~/.publican.cfg ]; then
    echo "Error: No ~/.publican.cfg found. This file is used to retrieve author information." 1>&2
    exit 1
fi

# Collect values to be used for revision history entry.
FIRSTNAME=`grep "^firstname: " ~/.publican.cfg | cut -f 2 -d ':' | tr -d ' '`
SURNAME=`grep "^surname: " ~/.publican.cfg | cut -f 2 -d ':' | tr -d ' '`
EMAIL=`grep "^email: " ~/.publican.cfg | cut -f 2 -d ':' | tr -d ' '`
DATE=`date +"%a %b %d %Y"`
COMMIT=`git log --pretty=format:"%H" -n 1`

if [ -z "${FIRSTNAME}" ]; then
    echo "Error: Unable to identify firstname key in ~/publican.cfg." 1>&2
    exit 1
fi

if [ -z "${SURNAME}" ]; then
    echo "Error: Unable to identify surname key in ~/publican.cfg." 1>&2
    exit 1
fi

if [ -z "${EMAIL}" ]; then
    echo "Error: Unable to identify email key in ~/publican.cfg." 1>&2
    exit 1
fi

# We need pom.xml to work out the source directory for the book.
if [ ! -f ./pom.xml ]; then
    echo "Error: No pom.xml file in current directory." 1>&2
    exit 1
fi

# Extract the source directory and book file name from pom.xml.
SOURCE_DIR_RELA=`${XSLT_PROC} pom.xml ${XSLT_DIR}/extract/sourceDirectory.xsl`
SOURCE_DIR_ABSL=`readlink -e ${SOURCE_DIR_RELA}`
SOURCE_DIR_PARA=`dirname ${SOURCE_DIR_ABSL}`
SOURCE_XML=`${XSLT_PROC} pom.xml ${XSLT_DIR}/extract/sourceDirectory-includes.xsl`

if [ ! -d ${SOURCE_DIR_ABSL} ]; then
    echo "Error: Unable to identify source dir (tried '${SOURCE_DIR_ABSL}')."
    exit 1
fi

if [ ! -f ${SOURCE_DIR_ABSL}/${SOURCE_XML} ]; then
    echo "Error: Unable to identify book file (tried '${SOURCE_XML}')."
    exit 1
fi

# Set the expected 'short' parameters, note the inclusion of '-'.
OPTSPEC=":-:"
OPT_BRAND=
OPT_CONDITION=
OPT_CONFIG=
OPT_OUTPUT=
OPT_PRODUCT_NAME=
OPT_PRODUCT_NUMBER=
OPT_TITLE=
OPT_SUBTITLE=

# Loop through the arguments used to call the script, handling flags and their
# arguments, where applicable.
while getopts "${OPTSPEC}" OPTCHAR; do
    case "${OPTCHAR}" in
        # Long arguments start with a - (getopts has already stripped the
        # leading '-').
        -)
            case "${OPTARG}" in
                brand)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_BRAND="${VAL}"
                    ;;
                brand=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_BRAND="${VAL}"
                    ;;
                condition)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_CONDITION="${VAL}"
                    ;;
                condition=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_CONDITION="${VAL}"
                    ;;
                config)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_CONFIG="${VAL}"
                    ;;
                config=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_CONFIG="${VAL}"
                    ;;
                output)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_OUTPUT="${VAL}"
                    ;;
                output=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_OUTPUT="${VAL}"
                    ;;
                productname)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_PRODUCT_NAME="${VAL}"
                    ;;
                productname=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_PRODUCT_NAME="${VAL}"
                    ;;
                productnumber)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_PRODUCT_NUMBER="${VAL}"
                    ;;
                productnumber=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_PRODUCT_NUMBER="${VAL}"
                    ;;
                title)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_TITLE="${VAL}"
                    ;;
                title=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_TITLE="${VAL}"
                    ;;
                subtitle)
                    VAL="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    OPT_SUBTITLE="${VAL}"
                    ;;
                subtitle=*)
                    VAL=${OPTARG#*=}
                    OPT=${OPTARG%=$VAL}
                    OPT_SUBTITLE="${VAL}"
                    ;;
                *)
                    if [ "${OPTERR}" = 1 ] && [ "${OPTSPEC:0:1}" != ":" ]; then
                        echo "ERROR: Unsupported option '--${OPTARG}'." >&2
                        exit 1
                    fi
                    ;;
            esac;;
        # Catch all for any other arguments, note that this is only catching
        # arguments starting with a '-', which has been strippted by getopts
        # already. This means the TOPIC_ID is allowed to flow through for 
        # further processing.
        *)
            if [ "${OPTERR}" != 1 ] || [ "${OPTSPEC:0:1}" = ":" ]; then
                echo "ERROR: Un-expected non-option argument: '-${OPTARG}'" >&2
                exit 1
            fi
            ;;
    esac
done

# Set working directory, if the user specified one then use it otherwise
# generate using mktemp.
DEST_DIR_ABSL=
if [ -z "${OPT_OUTPUT}" ]; then
    DEST_DIR_ABSL=`mktemp --directory --suffix=".publicanize"`
else
    if [ ! -d "${OPT_OUTPUT}" ]; then
        mkdir -p ${OPT_OUTPUT}
    fi
    DEST_DIR_ABSL=`readlink -e ${OPT_OUTPUT}`
fi

DEST_DIR_ABSL_SRC="${DEST_DIR_ABSL}/en-US"
mkdir -p ${DEST_DIR_ABSL_SRC}

echo "Source: ${SOURCE_DIR_ABSL}"
echo "Source Root file: ${SOURCE_DIR_ABSL}/${SOURCE_XML}"
echo "Destination: ${DEST_DIR_ABSL}"
echo "Destination Root file: ${DEST_DIR_ABSL}/en-US/${SOURCE_XML}"

# Copy all content into working directories.
echo "Copying content."
cp -r ${SOURCE_DIR_ABSL}/* ${DEST_DIR_ABSL_SRC}
cp -r `dirname ${TOP_DIR}`/common ${DEST_DIR_ABSL_SRC}/common

# Clean up inadvertantly copied pom.xml files. They, result in spurious errors
# from publican if left in the tree.
for POM in `find ${DEST_DIR_ABSL_SRC} -name 'pom.xml'`; do
    rm ${POM}
done

# Move files into the locations publican expects. Using symlinks for this does
# not work because publican does not follow them when copying for build, breaking
# the links.
if [ -d "${DEST_DIR_ABSL_SRC}/locale" ]; then
    mv ${DEST_DIR_ABSL_SRC}/locale ${DEST_DIR_ABSL}/pot
else
    mkdir ${DEST_DIR_ABSL_SRC}/pot
fi

if [ -d "${DEST_DIR_ABSL_SRC}/figures" ]; then
    mv ${DEST_DIR_ABSL_SRC}/figures ${DEST_DIR_ABSL_SRC}/images
else
    mkdir ${DEST_DIR_ABSL_SRC}/images
fi

if [ -d "${DEST_DIR_ABSL_SRC}/samples" ]; then
    mv ${DEST_DIR_ABSL_SRC}/samples ${DEST_DIR_ABSL_SRC}/extras
else
    mkdir ${DEST_DIR_ABSL_SRC}/extras
fi

if [ -d "${DEST_DIR_ABSL_SRC}/common/figures" ]; then
    mv ${DEST_DIR_ABSL_SRC}/common/figures ${DEST_DIR_ABSL_SRC}/images/common
fi

if [ -d "${DEST_DIR_ABSL_SRC}/common/samples" ]; then
    mv ${DEST_DIR_ABSL_SRC}/common/samples ${DEST_DIR_ABSL_SRC}/extras/common
fi

# Transformations...till all are one!
echo "Performing common transformations."
for XML in `find ${DEST_DIR_ABSL_SRC} -name '*.xml'`; do
    ${XSLT_PROC} ${XML} ${XSLT_DIR}/transform/all.xsl > ${XML}.new
    mv ${XML}.new ${XML}
done

# Transformation for files in "common" to get the correct images and extras.
for XML in `find ${DEST_DIR_ABSL_SRC}/common -name '*.xml'`; do
    ${XSLT_PROC} ${XML} ${XSLT_DIR}/transform/common.xsl > ${XML}.new
    mv ${XML}.new ${XML}
done

# Now to check for other content which has been included from higher level
# directories... We're going to work around this but also raise it as a
# warning.
for XML in `find ${DEST_DIR_ABSL_SRC} -name '*.xml'`; do
    for INCLUDE in `${XSLT_PROC} ${XML} ${XSLT_DIR}/extract/xiincludes-xml.xsl`; do
        echo "WARNING: ${XML} includes ${INCLUDE}."
    done
done


# Copy common XML files. These will be injected into the book. Note that they
# are copied after the common transformations are run intentionally. These are
# expected to be "publican compatible" already.
cp ${XML_DIR}/Preface.xml ${DEST_DIR_ABSL_SRC}/
cp ${XML_DIR}/Legal_Notice.xml ${DEST_DIR_ABSL_SRC}/
cp ${XML_DIR}/Revision_History.xml ${DEST_DIR_ABSL_SRC}/
cp ${XML_DIR}/Author_Group.xml ${DEST_DIR_ABSL_SRC}/

echo "Performing revision history transformations."
${XSLT_PROC} ${DEST_DIR_ABSL_SRC}/Revision_History.xml ${XSLT_DIR}/transform/revhistory-populate.xsl \
             date="${DATE}" \
             firstname="${FIRSTNAME}" \
             surname="${SURNAME}" \
             email="${EMAIL}" \
             commit="${COMMIT}" \
             productnumber="${OPT_PRODUCT_NUMBER}" > ${DEST_DIR_ABSL_SRC}/Revision_History.xml.new
mv ${DEST_DIR_ABSL_SRC}/Revision_History.xml.new ${DEST_DIR_ABSL_SRC}/Revision_History.xml

echo "Performing book file transformations."
${XSLT_PROC} ${DEST_DIR_ABSL_SRC}/${SOURCE_XML} ${XSLT_DIR}/transform/book.xsl \
             productname="${OPT_PRODUCT_NAME}" \
             productnumber="${OPT_PRODUCT_NUMBER}" \
             title="${OPT_TITLE}" \
             subtitle="${OPT_SUBTITLE}" \
             > ${DEST_DIR_ABSL_SRC}/${SOURCE_XML}.new
mv ${DEST_DIR_ABSL_SRC}/${SOURCE_XML}.new ${DEST_DIR_ABSL_SRC}/${SOURCE_XML}

# Write a publican.cfg file using either the bundled configuration or a user
# supplied one as a template. then replace key values based on user input and/or
# source files.
echo "Writing publican.cfg."
if [ -f "${OPT_CONFIG}" ]; then
    cp ${OPT_CONFIG} ${DEST_DIR_ABSL}/publican.cfg
else
    cp ${CFG_DIR}/publican.cfg ${DEST_DIR_ABSL}/publican.cfg
fi

# Always updated the source XML file name.
sed -i -e "s/SOURCE_XML/${SOURCE_XML%.*}/g" ${DEST_DIR_ABSL}/publican.cfg

# If a brand was set use it, otherwise use common-db5 by default.
if [ ! -z "${OPT_BRAND}" ]; then
    sed -i -e "s/BRAND/${OPT_BRAND}/g" ${DEST_DIR_ABSL}/publican.cfg
else
    sed -i -e "s/BRAND/common-db5/g" ${DEST_DIR_ABSL}/publican.cfg
fi

# If a condition was set then append it to the file.
if [ ! -z "${OPT_CONDITION}" ]; then
    echo "condition: ${OPT_CONDITION}" >> ${DEST_DIR_ABSL}/publican.cfg
fi

echo "Writing ${SOURCE_XML/\.xml/.ent}"
cat > ${DEST_DIR_ABSL_SRC}/${SOURCE_XML/\.xml/.ent} <<DELIM
<!ENTITY PRODUCT "${OPT_PRODUCT_NAME}">
<!ENTITY BOOKID "">
<!ENTITY YEAR "`date +"%Y"`">
<!ENTITY HOLDER "Red Hat, Inc">
DELIM

# Remove unused XML files. These are largely files that were bulk copied with
# common content but are not used in this specific book.
cd ${DEST_DIR_ABSL}
for FILE in `publican print_unused --nocolours | grep '\.xml$'`;
    do rm ./en-US/${FILE};
done
cd -
