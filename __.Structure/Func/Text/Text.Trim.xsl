<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   
    <!-- Trim implementation from http://stackoverflow.com/a/13974710/390940 -->
    
    <xsl:variable name="Text.Trim.Whitespaces" select="'&#09;&#10;&#13; '" />
    
    <!-- Strips trailing whitespace characters from 'string' -->
    <xsl:template name="Text.TrimRight">
        <xsl:param name="string" />
        <xsl:param name="whitespaces" select="$Text.Trim.Whitespaces" />
        
        <xsl:variable name="length" select="string-length($string)" />
        
        <xsl:if test="0 &lt; $length">
            <xsl:choose>
                <xsl:when test="contains($whitespaces, substring($string, $length, 1))">
                    <xsl:call-template name="Text.TrimRight">
                        <xsl:with-param name="string" select="substring($string, 1, $length - 1)" />
                        <xsl:with-param name="whitespaces"   select="$whitespaces" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <!-- Strips leading whitespace characters from 'string' -->
    <xsl:template name="Text.TrimLeft">
        <xsl:param name="string" />
        <xsl:param name="whitespaces" select="$Text.Trim.Whitespaces" />
        
        <xsl:if test="0 &lt; string-length($string)">
            <xsl:choose>
                <xsl:when test="contains($whitespaces, substring($string, 1, 1))">
                    <xsl:call-template name="Text.TrimLeft">
                        <xsl:with-param name="string" select="substring($string, 2)" />
                        <xsl:with-param name="whitespaces"   select="$whitespaces" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <!-- Strips leading and trailing whitespace characters from 'string' -->
    <xsl:template name="Text.Trim">
        <xsl:param name="string" />
        <xsl:param name="whitespaces" select="$Text.Trim.Whitespaces" />
        
        <xsl:call-template name="Text.TrimRight">
            <xsl:with-param name="string">
                <xsl:call-template name="Text.TrimLeft">
                    <xsl:with-param name="string" select="$string" />
                    <xsl:with-param name="whitespaces" select="$whitespaces" />
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="whitespaces" select="$whitespaces" />
        </xsl:call-template>
    </xsl:template>
    

</xsl:stylesheet>
