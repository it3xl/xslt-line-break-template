<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template name="Text.FO.InsertDelimiters">
        <!-- Puts line delimiter blocks instead of the specified string pointer (the default pointer is \n - &#10;). -->
        
        <xsl:param name="input" select="''" />
        <xsl:param name="pointer" />
        <xsl:param name="size" />
        <!-- Let's ignore repetion of input pointers. -->
        <xsl:param name="ignorePointerRepetition" select="false()" />
        
        <xsl:call-template name="Text.FO.__InsertDelimitersForTrimmed">
            <xsl:with-param name="input">
                <!-- Trim for the input string is required.
                    You have to use your own layouts for pre- and post indentations. -->
                <xsl:call-template name="Text.Trim">
                    <xsl:with-param name="string" select="$input" />
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="pointer" select="$pointer" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="ignorePointerRepetition" select="$ignorePointerRepetition" />
        </xsl:call-template>    
    </xsl:template>
    
    <xsl:template name="Text.FO.__InsertDelimitersForTrimmed">
        <!-- Do not use in your code. -->
        
        <xsl:param name="input" select="''" />
        <!-- We can't specify default value "\n" (select="'&#10;'")! It'll be ignored here.
            Will set it recursively later. -->
        <xsl:param name="pointer" />
        <xsl:param name="size" />
        <!-- Let's ignore repetion of pointers. -->
        <xsl:param name="ignorePointerRepetition" select="false()" />
        
        <xsl:variable name="isTrace" select="true()"/>
        
        <xsl:choose>
            <xsl:when test="0 &lt; string-length($pointer)">
                <xsl:choose>
                    <xsl:when test="contains($input, $pointer)">
                        <xsl:variable name="textBefore" select="substring-before($input, $pointer)" />
                        <xsl:variable name="textAfter" select="substring-after($input, concat($textBefore, $pointer))" />
                        
                        <xsl:variable name="emptyBefore" select="0 = string-length($textBefore)"/>
                        <xsl:variable name="haveBefore" select="not($emptyBefore)"/>
                        <xsl:variable name="haveAfter" select="0 &lt; string-length($textAfter)"/>
                        
                        <xsl:if test="$haveBefore or ($haveAfter and $ignorePointerRepetition = false() )">
                            <xsl:value-of select="$textBefore" />
                            
                            <xsl:choose>
                                <xsl:when test="$size">
                                    <fo:block>
                                        <xsl:attribute name="margin-top">
                                            <xsl:value-of select="$size" />
                                        </xsl:attribute>
                                        <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                    </fo:block>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:block>
                                        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
                                        <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                        <xsl:value-of select="' '"/>
                                    </fo:block>
                                    <!-- Other approach. Do not format next XML because of behaviour of the linefeed-treatment attribute. -->
                                    <!--<fo:block linefeed-treatment="preserve"><xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if><xsl:value-of select="'&#10;'" /></fo:block>-->
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        
                        <xsl:call-template name="Text.FO.__InsertDelimitersForTrimmed">
                            <xsl:with-param name="input" select="$textAfter" />
                            <xsl:with-param name="pointer" select="$pointer" />
                            <xsl:with-param name="size" select="$size" />
                            <xsl:with-param name="ignorePointerRepetition" select="$ignorePointerRepetition" />
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
                <!-- Let's set default pointer recursively. -->
                <xsl:call-template name="Text.FO.__InsertDelimitersForTrimmed">
                    <xsl:with-param name="input" select="$input" />
                    <xsl:with-param name="pointer" select="'&#10;'" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="ignorePointerRepetition" select="$ignorePointerRepetition" />
                </xsl:call-template>
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
    
    
</xsl:stylesheet>
