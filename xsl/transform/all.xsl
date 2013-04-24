<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

  <!-- xsl variables up and lo and translate() are used to change case -->
  <xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lo" select="'abcdefghijklmnopqrstuvwxyz'"/>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@os">
    <xsl:attribute name="condition">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@language">
    <xsl:attribute name="language">
      <xsl:choose>
        <xsl:when test="translate(.,$lo,$up) = '.DESKTOP'">
          <xsl:text>.desktop</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '4GL'">
          <xsl:text>4GL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '4GL-PER'">
          <xsl:text>4GL-PER</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ABC'">
          <xsl:text>ABC</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'AHDL'">
          <xsl:text>AHDL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ANSI'">
          <xsl:text>ANSI</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'C89'">
          <xsl:text>C89</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ASP'">
          <xsl:text>ASP</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'AVR'">
          <xsl:text>AVR</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ASSEMBLER'">
          <xsl:text>Assembler</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'AWK'">
          <xsl:text>AWK</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ADA'">
          <xsl:text>Ada</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ANSYS'">
          <xsl:text>Ansys</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'APACHE'">
          <xsl:text>Apache</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CONFIGURATION'">
          <xsl:text>Configuration</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ASM6502'">
          <xsl:text>Asm6502</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'BASH'">
          <xsl:text>Bash</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'BIBTEX'">
          <xsl:text>BibTeX</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'C'">
          <xsl:text>C</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'C#'">
          <xsl:text>C#</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'C++'">
          <xsl:text>C++</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CGIS'">
          <xsl:text>CGiS</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CMAKE'">
          <xsl:text>CMake</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CSS'">
          <xsl:text>CSS</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CUE'">
          <xsl:text>CUE</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SHEET'">
          <xsl:text>Sheet</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CG'">
          <xsl:text>Cg</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CHANGELOG'">
          <xsl:text>ChangeLog</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CISCO'">
          <xsl:text>Cisco</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CLIPPER'">
          <xsl:text>Clipper</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'COLDFUSION'">
          <xsl:text>ColdFusion</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'COMMON'">
          <xsl:text>Common</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LISP'">
          <xsl:text>Lisp</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'COMPONENT-PASCAL'">
          <xsl:text>Component-Pascal</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'D'">
          <xsl:text>D</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'DEBIAN'">
          <xsl:text>Debian</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CHANGELOG'">
          <xsl:text>Changelog</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'DEBIAN'">
          <xsl:text>Debian</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CONTROL'">
          <xsl:text>Control</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'DIFF'">
          <xsl:text>Diff</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'DOXYGEN'">
          <xsl:text>Doxygen</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'E'">
          <xsl:text>E</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LANGUAGE'">
          <xsl:text>Language</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'EIFFEL'">
          <xsl:text>Eiffel</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'EMAIL'">
          <xsl:text>Email</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'EUPHORIA'">
          <xsl:text>Euphoria</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'FORTRAN'">
          <xsl:text>Fortran</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'FREEBASIC'">
          <xsl:text>FreeBASIC</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'GDL'">
          <xsl:text>GDL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'GLSL'">
          <xsl:text>GLSL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'GNU'">
          <xsl:text>GNU</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ASSEMBLER'">
          <xsl:text>Assembler</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'GNU'">
          <xsl:text>GNU</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'GETTEXT'">
          <xsl:text>Gettext</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'HTML'">
          <xsl:text>HTML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'HASKELL'">
          <xsl:text>Haskell</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'IDL'">
          <xsl:text>IDL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ILERPG'">
          <xsl:text>ILERPG</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'INI'">
          <xsl:text>INI</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'FILES'">
          <xsl:text>Files</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'INFORM'">
          <xsl:text>Inform</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'INTEL'">
          <xsl:text>Intel</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'X86'">
          <xsl:text>x86</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '(NASM)'">
          <xsl:text>(NASM)</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JSP'">
          <xsl:text>JSP</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JAVA'">
          <xsl:text>Java</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JAVASCRIPT'">
          <xsl:text>JavaScript</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JSON'">
          <xsl:text>JavaScript</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JAVADOC'">
          <xsl:text>Javadoc</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'KBASIC'">
          <xsl:text>KBasic</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'KATE'">
          <xsl:text>Kate</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'FILE'">
          <xsl:text>File</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'TEMPLATE'">
          <xsl:text>Template</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LDIF'">
          <xsl:text>LDIF</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LPC'">
          <xsl:text>LPC</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LATEX'">
          <xsl:text>LaTeX</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LEX/FLEX'">
          <xsl:text>Lex/Flex</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LILYPOND'">
          <xsl:text>LilyPond</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LITERATE'">
          <xsl:text>Literate</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'HASKELL'">
          <xsl:text>Haskell</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'LUA'">
          <xsl:text>Lua</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'M3U'">
          <xsl:text>M3U</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MAB-DB'">
          <xsl:text>MAB-DB</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MIPS'">
          <xsl:text>MIPS</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'ASSEMBLER'">
          <xsl:text>Assembler</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MAKEFILE'">
          <xsl:text>Makefile</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MASON'">
          <xsl:text>Mason</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MATLAB'">
          <xsl:text>Matlab</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MODULA-2'">
          <xsl:text>Modula-2</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'MUSIC'">
          <xsl:text>Music</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PUBLISHER'">
          <xsl:text>Publisher</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'OCTAVE'">
          <xsl:text>Octave</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PHP'">
          <xsl:text>PHP</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '(HTML)'">
          <xsl:text>(HTML)</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'POV-RAY'">
          <xsl:text>POV-Ray</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PASCAL'">
          <xsl:text>Pascal</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PERL'">
          <xsl:text>Perl</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PICASM'">
          <xsl:text>PicAsm</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PIKE'">
          <xsl:text>Pike</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'POSTSCRIPT'">
          <xsl:text>PostScript</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PROLOG'">
          <xsl:text>Prolog</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PUREBASIC'">
          <xsl:text>PureBasic</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PYTHON'">
          <xsl:text>Python</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'QUAKE'">
          <xsl:text>Quake</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SCRIPT'">
          <xsl:text>Script</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'R'">
          <xsl:text>R</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SCRIPT'">
          <xsl:text>Script</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'REXX'">
          <xsl:text>REXX</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'RPM'">
          <xsl:text>RPM</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SPEC'">
          <xsl:text>Spec</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'RSI'">
          <xsl:text>RSI</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'IDL'">
          <xsl:text>IDL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'RENDERMAN'">
          <xsl:text>RenderMan</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'RIB'">
          <xsl:text>RIB</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'RUBY'">
          <xsl:text>Ruby</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SGML'">
          <xsl:text>SGML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SML'">
          <xsl:text>SML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SQL'">
          <xsl:text>SQL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SQL'">
          <xsl:text>SQL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '(MYSQL)'">
          <xsl:text>(MySQL)</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SQL'">
          <xsl:text>SQL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '(POSTGRESQL)'">
          <xsl:text>(PostgreSQL)</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SATHER'">
          <xsl:text>Sather</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SCHEME'">
          <xsl:text>Scheme</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SIEVE'">
          <xsl:text>Sieve</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SPICE'">
          <xsl:text>Spice</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'STATA'">
          <xsl:text>Stata</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'TI'">
          <xsl:text>TI</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'BASIC'">
          <xsl:text>Basic</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'TASKJUGGLER'">
          <xsl:text>TaskJuggler</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'TCL/TK'">
          <xsl:text>Tcl/Tk</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'UNREALSCRIPT'">
          <xsl:text>UnrealScript</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'VHDL'">
          <xsl:text>VHDL</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'VRML'">
          <xsl:text>VRML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'VELOCITY'">
          <xsl:text>Velocity</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'VERILOG'">
          <xsl:text>Verilog</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'WINE'">
          <xsl:text>WINE</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CONFIG'">
          <xsl:text>Config</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'WIKIMEDIA'">
          <xsl:text>Wikimedia</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'XML'">
          <xsl:text>XML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'XML'">
          <xsl:text>XML</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = '(DEBUG)'">
          <xsl:text>(Debug)</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'YACC/BISON'">
          <xsl:text>Yacc/Bison</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'DE_DE'">
          <xsl:text>de_DE</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'EN_EN'">
          <xsl:text>en_EN</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'FERITE'">
          <xsl:text>ferite</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'NL'">
          <xsl:text>nl</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'PROGRESS'">
          <xsl:text>progress</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'SCILAB'">
          <xsl:text>scilab</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'TXT2TAGS'">
          <xsl:text>txt2tags</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'X.ORG'">
          <xsl:text>x.org</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'CONFIGURATION'">
          <xsl:text>Configuration</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'XHARBOUR'">
          <xsl:text>xHarbour</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'XSLT'">
          <xsl:text>xslt</xsl:text>
        </xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'YACAS'">
          <xsl:text>yacas</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Replace xi:include references with updated locations. -->
  <xsl:template match="xi:include[@href]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:choose>
        <xsl:when test="matches(@href, '^[\./]*samples')">
          <xsl:attribute name="href">
            <xsl:value-of select="replace(@href,'^[\./]*samples','./extras')" />
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="matches(@href, '^[\./]*common')">
          <xsl:attribute name="href">
            <xsl:value-of select="replace(@href,'^[\./]*common','./common')" />
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="href">
            <xsl:value-of select="@href" />
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- Replace references to "figures" directory with references to "images". -->
  <xsl:template match="d:imagedata[@fileref]">
    <xsl:copy>
      <xsl:attribute name="fileref">
        <xsl:value-of select="replace(@fileref,'^[\./]*figures','./images')" />
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- Strip revision history in rebase operation. -->
  <xsl:template match="d:revhistory"></xsl:template>

</xsl:stylesheet>
