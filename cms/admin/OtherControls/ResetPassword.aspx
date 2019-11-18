<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="SubControls_ResetPassword" %>

<%@ Import Namespace="TatThanhJsc"%>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Khu vực đăng nhập hệ thống quản trị website</title>
    <meta name="copyright" content="Tat Thanh JSC" />
    <meta name="author" content="TatThanhCMS/VersionT3.0" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.3)" />
    <link href="../cs/Login.css" rel="stylesheet" type="text/css" />
</head>
<body class="m0">
    <form id="form1" runat="server">
    <div align="center">
        <div id="ResetPassword">
            <div class="FormatCollumn1">
                <div class="pdContainCollumn1">
                    <div><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/ImageHello.png" /></div>
                    <div class="pdAdv"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/ImageAdv.png" /></div>
                    <div>
                        <div class="FormatStarIcon"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/StarIcon.png" /></div>
                        <div class="DescSystemCmsTatThanhJsc">ƯU ĐIỂM CỦA HỆ THỐNG QUẢN TRỊ WEBSITE TẤT THÀNH</div>
                        <div class="cbh0"><!----></div>
                    </div>
                    <div class="ContentSystemCmsTatThanhJsc">
                        <div class="pdLineContentCms"><b>Dễ sử dụng:</b> hệ thống quản trị TATTHANH-CMS liên tục được nâng cấp để công việc quản trị website ngày càng dễ dàng hơn.</div>                        <div class="pdLineContentCms"><b>Cấu trúc đồng nhất:</b> các module của website có chung cách bố trí các tính năng. Vì vậy, người quản trị chỉ cần làm quen với việc quản lý một module là có thể dễ dàng sử dụng các module khác.</div>                        <div class="pdLineContentCms"><b>Bảo mật:</b> hệ thống được xây dựng trên công nghệ ASP.NET và cơ sở dữ liệu SQL Server của Micosoft, có tính bảo mật và an toàn dữ liệu cao.</div>                        <div class="pdLineContentCms"><b>Tính năng cao cấp:</b> hệ thống còn cung cấp các tính năng cao cấp như: thống kê báo cáo, thùng rác, thêm mới nhanh dữ liệu, tối ưu website cho các công cụ tìm kiếm, ...</div>                        <div class="pdBtnViewAll" align="right"><a href="http://tatthanh.com.vn/tin-tuc.htm"><img src="../cms/admin/cs/Login/BtnViewAll.png" border="0" /></a></div>
                    </div>
                    <div>
                        <div class="FormatInformationIcon"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/InformationIcon.png" /></div>
                        <div class="DescSystemCmsTatThanhJsc">THÔNG TIN HỮU ÍCH</div>
                        <div class="cbh8"><!----></div>
                        <div>
                            <a target="_blank" title="Giới thiệu về Tat Thanh JSC" href="http://tatthanh.com.vn/gioi-thieu-chung.htm" class="LinkAboutTatThanhJsc">Giới thiệu về Tat Thanh JSC</a>
                            <div class="SpaceLinkAboutTatThanhJsc">|</div>
                            <a target="_blank" title="Liên hệ xây dựng website" href="http://www.tatthanh.com.vn/lien-he.htm" class="LinkAboutTatThanhJsc">Liên hệ xây dựng website</a>
                            <div class="cbh0"><!----></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="FormatCollumn2">
                <div class="pdContainCollumn2">
                    <div><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/TopFormLogin.png" /></div>
                    <div class="bgFormLogin">
                        <div class="bgTabTitle">
                            <div class="bgBottomFormLogin">
                                <div class="TitleLogin">Khôi phục mật khẩu quản trị website</div>
                                <div class="TextMesLogin"><asp:Literal ID="lt_message" runat="server"></asp:Literal></div>
                                <div class="TitleAccountPass">
                                <div class="ColAccountPassword"><div class="pdFormLogin">Tài khoản:</div></div>
                                <div class="ColTextBoxAccountPass">
                                    <asp:TextBox ID="TbAccount" runat="server" Width="160px" CssClass="textbox_format2"></asp:TextBox>
                                    <div class="fwn">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ErrorMessage="Vui lòng nhập tài khoản! " ControlToValidate="TbAccount" 
                                            Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="cbh8"><!----></div>                                                                
                                <div class="pdCheckBox">
                                    <div class="cbh17"><!----></div>
                                    <div><asp:Button ID="BtnLogin" runat="server" Text="" CssClass="BtnLogin"  onclick="BtnLogin_Click" /></div>                                           
                                </div>
                                <div class="pdSpaceContentForm"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/spaceContentForm.png" /></div>
                                <div class="TitleSupport">HỖ TRỢ</div>
                                <div class="SupportLinkAboutTatThanhJsc">
                                    <div class="FormatColIconSupport"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/SupportIcon.png" /></div>
                                    <asp:LinkButton ID="LBLogin" runat="server" ToolTip="Đăng nhập" 
                                        onclick="LBLogin_Click" CausesValidation="false">Đăng nhập</asp:LinkButton>
                                    <div class="cbh15"><!----></div>
                                    <div class="FormatColIconSupport"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/SupportIcon.png" /></div>

                                    <a target="_blank" title="Liên hệ bộ phận hỗ trợ khách hàng" href="http://www.tatthanh.com.vn/">Liên hệ bộ phận hỗ trợ khách hàng</a>
                                    <div class="cbh15"><!----></div>
                                    <div class="FormatColIconSupport"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/SupportIcon.png" /></div>
                                    <a target="_blank" title="Liên hệ bộ phận tư vấn" href="http://www.tatthanh.com.vn/">Liên hệ bộ phận tư vấn</a>
                                    <div class="cbh15"><!----></div>
                                    <div class="FormatColIconSupport"><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/SupportIcon.png" /></div>
                                    <a target="_blank" title="Liên hệ bộ phận kỹ thuật" href="http://www.tatthanh.com.vn/">Liên hệ bộ phận kỹ thuật</a>
                                    <div class="cbh15"><!----></div>
                                </div>
                                <div class="BanQuyen">@ Bản quyền thuộc về TAT THANH JSC</div>
                            </div>
                        </div>
                    </div>
                    <div><img src="<%=UrlExtension.WebisteUrl %>cms/admin/cs/Login/BottomFormLogin.png" /></div>
                </div>
            </div>
            <div class="cbh0"><!----></div>
        </div>
    </div>
    </form>
</body>
</html>
