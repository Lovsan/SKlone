<%@ Register TagPrefix="sklone" TagName="BottomInfoBar" Src="BottomInfoBar.ascx" %>
<%@ Register TagPrefix="sklone" TagName="TopInfoBar" Src="TopInfoBar.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PostErrorB.aspx.vb" Inherits="SKlone.PostErrorB" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Status</TITLE>
		<ASP:LABEL id="lblLand" runat="server"></ASP:LABEL>
		<META content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<META content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<META content="JavaScript" name="vs_defaultClientScript">
		<META content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<STYLE>A:link { COLOR: #447cff; TEXT-DECORATION: none }
	A:visited { COLOR: #447cff; TEXT-DECORATION: none }
	A:hover { COLOR: #4e9f5f; TEXT-DECORATION: underline }
		</STYLE>
	</HEAD>
	<BODY text="#ffffff" vlink="#447cff" alink="#4e9f5f" link="#447cff" bgcolor="#000000">
		<P align="center"><BR>
		</P>
		<P align="center"><SKLONE:TOPINFOBAR id="Topinfobar1" runat="server"></SKLONE:TOPINFOBAR></P>
		<FONT face="verdana" size="1">
			<FORM id="Form1" runat="server">
				<P align="center">&nbsp;</P>
				<P align="center">You have tried to send more then 1500 bytes of date in your 
					message or you have tried to send more then 50 bytes in your thread name. Hit 
					the back button and correct the error(s).</P>
				<P align="center">&nbsp;</P>
			</FORM>
		</FONT>
		<P align="center"><SKLONE:BOTTOMINFOBAR id="BottomInfoBar1" runat="server"></SKLONE:BOTTOMINFOBAR></P>
	</BODY>
</HTML>
