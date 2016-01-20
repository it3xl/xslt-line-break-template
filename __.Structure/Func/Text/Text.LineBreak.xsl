<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template name="Text.FO.InsertBreaks">
        <!-- Puts line breaks instead of the specified string delimiter (the default delimiter is \n - &#10;). -->
        
        <xsl:param name="input" select="''" />
        <xsl:param name="delimiter" />
        
        <xsl:call-template name="Text.FO.__InsertBreaksForTrimmed">
            <xsl:with-param name="input">
                <!-- Trim for the input string is required.
                    You have to use your own layouts for pre- and post indentations. -->
                <xsl:call-template name="Text.Trim">
                    <xsl:with-param name="string" select="$input" />
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="delimiter" select="$delimiter" />
        </xsl:call-template>    
    </xsl:template>
    
    <xsl:template name="Text.FO.__InsertBreaksForTrimmed">
        <!-- Do not use in your code. -->
        
        <xsl:param name="input" select="''" />
        <!-- We can't specify default value "\n" (select="'&#10;'")! It'll be ignored here.
            Will set it recursively later. -->
        <xsl:param name="delimiter" />
        
        <xsl:variable name="isTrace" select="false()"/>
        
        <xsl:choose>
            <xsl:when test="0 &lt; string-length($delimiter)">
                <xsl:choose>
                    <xsl:when test="contains($input, $delimiter)">
                        <xsl:variable name="textBefore" select="substring-before($input, $delimiter)" />
                        <xsl:variable name="textAfter" select="substring-after($input, concat($textBefore, $delimiter))" />
                        
                        <xsl:variable name="emptyBefore" select="0 = string-length($textBefore)"/>
                        <xsl:variable name="haveBefore" select="0 &lt; string-length($textBefore)"/>
                        <xsl:variable name="haveAfter" select="0 &lt; string-length($textAfter)"/>
                        
                        <xsl:choose>
                            
                            <xsl:when test="$haveBefore">
                                <fo:block>
                                    <!-- Let's preserve linebreak for "\r\n" (&#13;&#10;) and
                                        for case of doubled breaks with spaces between - "\n \n" -->
                                    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
                                    <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                    <xsl:value-of select="$textBefore" />
                                </fo:block>
                            </xsl:when>
                            
                            <xsl:when test="$emptyBefore and $haveAfter">
                                <!-- We have here the not first delimiter from a consecutive delimiters row. -->
                                <xsl:value-of select="$textBefore" />
                                <!-- Do not format next XML because of behaviour of the linefeed-treatment attribute. -->
                                <fo:block linefeed-treatment="preserve"><xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if><xsl:value-of select="'&#10;'" /></fo:block>
                            </xsl:when>
                            
                        </xsl:choose>
                        
                        <xsl:call-template name="Text.FO.__InsertBreaksForTrimmed">
                            <xsl:with-param name="input" select="$textAfter" />
                            <xsl:with-param name="delimiter" select="$delimiter" />
                        </xsl:call-template>
                        
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- We have completed. Let's interrupt recursion. -->
                        <fo:block>
                            <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                            <xsl:value-of select="$input" />
                        </fo:block>
                    </xsl:otherwise>
                    
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- Let's set default delimiter recursively. -->
                <xsl:call-template name="Text.FO.__InsertBreaksForTrimmed">
                    <xsl:with-param name="input" select="$input" />
                    <xsl:with-param name="delimiter" select="'&#10;'" />
                </xsl:call-template>
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
    
        
</xsl:stylesheet>
