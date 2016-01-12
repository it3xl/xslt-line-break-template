<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions">

    <xsl:include href="Text.Trim.xsl"/>


    <xsl:template name="Text.FO.InsertBreaks">
        <!-- it3xl.ru: Расставляет переносы строк перед указанным строковым указателем, если перед ним есть контент. -->
        <xsl:param name="input" select="''" />
        <xsl:param name="delimiter" />
        <xsl:param name="spacerSize" />
        
        <xsl:call-template name="Text.FO.__InsertBreaksForTrimmed">
            <xsl:with-param name="input">
                <!-- Обязательно сделаем trim для строки, т.к. требуем, чтоб отступы в начале и в конце задавать в разметке. -->
                <xsl:call-template name="Text.Trim">
                    <xsl:with-param name="string" select="$input" />
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="delimiter" select="$delimiter" />
            <xsl:with-param name="spacerSize" select="$spacerSize" />
        </xsl:call-template>    
    </xsl:template>
    
    <xsl:template name="Text.FO.__InsertBreaksForTrimmed">
        <!-- it3xl.com: Расставляет переносы строк перед указанным строковым указателем, если перед ним есть контент. -->
        
        <xsl:param name="input" select="''" />
        <!-- We can't specify default value "\n" here! It'll be ignored. (select="'&#10;'") -->
        <xsl:param name="delimiter" />
        <xsl:param name="spacerSize" />
        
        <xsl:variable name="isTrace" select="true()"/>
        
        <xsl:choose>
            <xsl:when test="contains($input, $delimiter)">
                <xsl:variable name="textBefore" select="substring-before($input, $delimiter)" />
                <xsl:variable name="textAfter" select="substring-after($input, concat($textBefore, $delimiter))" />
                
                <xsl:variable name="emptyBefore" select="0 = string-length($textBefore)"/>
                <xsl:variable name="haveBefore" select="0 &lt; string-length($textBefore)"/>
                <xsl:variable name="haveAfter" select="0 &lt; string-length($textAfter)"/>
                
                <xsl:choose>
                    
                    <xsl:when test="string-length($delimiter) = 0">
                        <!-- Let's interrupt splitting for an empty delimiter. -->
                        <xsl:value-of select="$input" />
                    </xsl:when>
                    
                    <xsl:when test="$haveBefore">
                        <!-- Есть текст перед разделителем. -->
                        <xsl:choose>
                            <xsl:when test="$spacerSize">
                                <xsl:value-of select="$textBefore" />
                                <!-- Have indent size. We'll use empty block with margin-top. -->
                                <fo:block>
                                    <xsl:attribute name="margin-top">
                                        <xsl:value-of select="$spacerSize" />
                                    </xsl:attribute>
                                    <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                </fo:block>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Зазмер блока не задан, поэтому выведем текст в отдельном блоке. -->
                                <fo:block>
                                    <!-- Let's preserve linebreak for "\r\n" (&#13;&#10;) and
                                        for case of doubled breaks with spaces between - "\n \n" -->
                                    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
                                    <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                    <xsl:value-of select="$textBefore" />
                                </fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$emptyBefore and $haveAfter">
                        <!-- Случай, когда идет подряд несколько разделителей. -->
                        <xsl:choose>
                            <xsl:when test="$spacerSize">
                                <xsl:value-of select="$textBefore" />
                                <!-- Have indent size. We'll use empty block with margin-top. -->
                                <fo:block>
                                    <xsl:attribute name="margin-top">
                                        <xsl:value-of select="$spacerSize" />
                                    </xsl:attribute>
                                    <xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if>
                                </fo:block>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Высота блока разделителя не задана, поэтому выведем выведем блок сохранающий переносы строк с одним переносом.
                                    Т.е. будет использоваться шрифт по умолчанию. -->
                                
                                <xsl:value-of select="$textBefore" />
                                <!-- Из-за сохранения переноса строк при задании атрибута "linefeed-treatment" в содержимом элемента и его атрибутах,
                                    следующую разметку нельзя форматировать и добавлять переносы строк!
                                    Иначе поведение нарушится. Будет мусор в атрибуте и в элементе-->
                                <!-- Т.е. следующая запись должна быть одной строкой! -->
                                <fo:block linefeed-treatment="preserve"><xsl:if test="$isTrace"><xsl:attribute name="border">0.1pt solid #F0F0F0</xsl:attribute></xsl:if><xsl:value-of select="'&#10;'" /></fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
                
                <xsl:value-of select="$delimiter" />
                
                <xsl:call-template name="Text.FO.__InsertBreaksForTrimmed">
                    <xsl:with-param name="input" select="$textAfter" />
                    <xsl:with-param name="delimiter" select="$delimiter" />
                    <xsl:with-param name="spacerSize" select="$spacerSize" />
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
        
    </xsl:template>
    

</xsl:stylesheet>
