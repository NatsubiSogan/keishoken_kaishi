<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/">

  <!-- 出力設定 -->
  <xsl:output method="xml" encoding="UTF-8" indent="no"/>

  <!-- 既定：素通し（既存の aid:* は維持） -->
  <xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template>

  <!-- Re:VIEW の処理命令 dtp は削除（任意） -->
  <xsl:template match="processing-instruction('dtp')"/>

  <!-- =========================
       見出し（h1/h2/h3）
       ========================= -->
  <!-- h1: <h1> / <title> / <hd level="1"> -->
  <xsl:template match="*[local-name()='h1'][not(@aid:pstyle)] | *[local-name()='title'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">h1</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*[local-name()='hd'][@level='1'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">h1</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- h2: <h2> / <hd level="2"> -->
  <xsl:template match="*[local-name()='h2'][not(@aid:pstyle)] | *[local-name()='hd'][@level='2'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">h2</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- h3: <h3> / <hd level="3"> -->
  <xsl:template match="*[local-name()='h3'][not(@aid:pstyle)] | *[local-name()='hd'][@level='3'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">h3</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- =========================
       段落・引用
       ========================= -->
  <!-- 段落 p -->
  <xsl:template match="*[local-name()='p'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">p</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- 引用 blockquote -->
  <xsl:template match="*[local-name()='blockquote'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">blockquote</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- =========================
       箇条書き・定義リスト
       ========================= -->
  <!-- ul/li → list-bullet -->
  <xsl:template match="*[local-name()='ul']/*[local-name()='li'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">list-bullet</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- ol/li → list-number -->
  <xsl:template match="*[local-name()='ol']/*[local-name()='li'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">list-number</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- 定義リスト dl: dt → dl-term / dd → dl-def -->
  <xsl:template match="*[local-name()='dl']/*[local-name()='dt'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">dl-term</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*[local-name()='dl']/*[local-name()='dd'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">dl-def</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- =========================
       図・表キャプション
       ========================= -->
  <!-- figure/caption → figure-caption -->
  <xsl:template match="*[local-name()='figure']/*[local-name()='caption'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">figure-caption</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- img/caption → figure-caption -->
  <xsl:template match="*[local-name()='img']/*[local-name()='caption'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">figure-caption</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- table/caption → table-caption -->
  <xsl:template match="*[local-name()='table']/*[local-name()='caption'][not(@aid:pstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:pstyle">table-caption</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- =========================
       インライン（文字スタイル）
       ========================= -->
  <!-- em / i → em -->
  <xsl:template match="*[local-name()='em'][not(@aid:cstyle)] | *[local-name()='i'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">em</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- strong / b → strong -->
  <xsl:template match="*[local-name()='strong'][not(@aid:cstyle)] | *[local-name()='b'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">strong</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- code / tt / kbd / samp → mono -->
  <xsl:template match="*[local-name()='code'][not(@aid:cstyle)] | *[local-name()='tt'][not(@aid:cstyle)] | *[local-name()='kbd'][not(@aid:cstyle)] | *[local-name()='samp'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">mono</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- a → link -->
  <xsl:template match="*[local-name()='a'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">link</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- cite / q → cite -->
  <xsl:template match="*[local-name()='cite'][not(@aid:cstyle)] | *[local-name()='q'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">cite</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- sup / sub -->
  <xsl:template match="*[local-name()='sup'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">sup</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*[local-name()='sub'][not(@aid:cstyle)]">
    <xsl:copy>
      <xsl:attribute name="aid:cstyle">sub</xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
