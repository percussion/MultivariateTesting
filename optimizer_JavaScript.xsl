<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY % HTMLlat1 SYSTEM "/Rhythmyx/DTD/HTMLlat1x.ent">
		%HTMLlat1;
	<!ENTITY % HTMLsymbol SYSTEM "/Rhythmyx/DTD/HTMLsymbolx.ent">
		%HTMLsymbol;
	<!ENTITY % HTMLspecial SYSTEM "/Rhythmyx/DTD/HTMLspecialx.ent">
		%HTMLspecial;
]>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:psxctl="URN:percussion.com/control" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="psxi18n" xmlns:psxi18n="urn:www.percussion.com/i18n" >
<xsl:template match="/" />
	<!--
     optimizer_JavaScript:
	 The custom control is javascript/jquery functionality that will show/hide Percussion CM System input fields depending on the values input by the user.   This is specific for the Google Optimizer implementation and does contain rules, names, and values particular to that configuration.  Specifically, the
 -->
	<psxctl:ControlMeta name="optimizer_JavaScript" dimension="single" choiceset="none">
		<psxctl:Description>Executes custom javascript</psxctl:Description>
		<psxctl:ParamList>
		</psxctl:ParamList>
	</psxctl:ControlMeta>
	<xsl:template match="Control[@name='optimizer_JavaScript']" mode="psxcontrol">
		<xsl:variable name="calendar_id" select="concat('perc-content-edit-', @paramName)" />
		<xsl:variable name="value" select="Value" />
		<script type="text/javascript">
			var autoControls = [
						'experiment',
						'experimentpage',
						'experimentscript'
						];
			var autoControlSubset = [
						'experimentheadline_2',
						'experimentheadline_3',
						];
			var autoControlComplete = autoControls.concat ( autoControlSubset );
			function findControls(controls) {
				controls = $.makeArray(controls);
				return $('tr > td[class=controlname]').find('label').filter(function(i) {
						var n = $(this).attr('for');
						return -1 != $.inArray(n, controls);
					}).parent().parent();
			}
			function doToggle() {
				var sExpTest = $('input[name=experimenttest]:checked').val();
				var sExpPage = $('input[name=experimentpage]:checked').val();
				if (sExpTest == 'None') {
					findControls(autoControlComplete).hide();
				}
				else {
					findControls(autoControls).show();
					if (sExpTest == 'AB Test') {
						findControls(autoControlSubset).hide();
					}
					else {
						if(sExpTest == 'Multivariate' && sExpPage == 'Test Page')
							findControls(autoControlSubset).show();
						else {
							findControls(autoControlSubset).hide();
						}
					}
				}
			}
			findControls(autoControlComplete).hide();
			doToggle();
			$('input[name=experimenttest]').change(function() {
				doToggle();
			});
			doToggle();
			$('input[name=experimentpage]').change(function() {
				doToggle();
			});
		</script>

	</xsl:template>
</xsl:stylesheet>
