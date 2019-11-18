<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ListMember.ascx.cs" Inherits="cms_admin_Moduls_Member_Control_ListMember" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.MemberModul" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Member/List/ListMember/ListMember.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
    
<div id="ListMember">
    <div class="BgTabTool">
        <asp:LinkButton CssClass="LinkDelete" ID="lbtDelete" runat="server" OnClientClick="return confirm('Bạn có chắc chắn muốn xoá các danh mục vừa chọn? Chú ý: danh mục còn chứa bài viết sẽ không bị xoá.');">Xóa</asp:LinkButton>                    
        
        <div class="right">            
            <div class="ColPagging"><div class="AdminPagging"><asp:Literal ID="LtPaggingTop" runat="server"></asp:Literal></div></div>
            <div class="ColShowItem">            
                <div class="TextShow">Hiển thị</div>
                <div class="BoxShow">
                    <asp:DropDownList ID="DdlListShowItemTop" runat="server" Width="50px" Height="19px" CssClass="TextInBox" AutoPostBack="True" 
                    onselectedindexchanged="DdlListShowItemTop_SelectedIndexChanged">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="cb"><!----></div>
            </div>                                         
        </div>  
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('chk_item',this)"/></div>
        <div class="split">|</div>
        <div class="cot2">Ảnh thành viên</div>
        <div class="split">|</div>
        <div class="cot3" align="left"><asp:LinkButton ID="lbtName" runat="server" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Thông tin thành viên</asp:LinkButton></div>                
        <div class="split">|</div>
        <div class="cot4">Số tin đăng</div>                
        <div class="split">|</div>
        <div class="cot5"><asp:LinkButton ID="LbTimeRegister" runat="server" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này" onclick="LbTimeRegister_Click">Đăng ký lúc</asp:LinkButton></div>                
        <div class="split">|</div>                    
        <div class="cot6"><asp:LinkButton ID="lbtStatus" runat="server" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Trạng thái</asp:LinkButton></div>                
        <div class="split">|</div>                    
        <div class="fr pr5">Công cụ</div>                    
        <div class="cb"><!----></div>                                    
    </div>
    <div align="center">
        <asp:Repeater ID="RpListMembers" runat="server" 
            onitemcommand="RpListMembers_ItemCommand">
            <ItemTemplate>
                <div class="bgItem">
                    <div class="cot1"><asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("imid") %>'/></div>                            
                    <div class="split">|</div>                            
                    <div class="cot2" align="left">
                        <%#ImagesExtension.GetImage(FolderPic.Member, Eval("vMemberImage").ToString(), Eval("vMemberName").ToString(), "SizeImgMem", true, false, "")%>
                    </div>                            
                    <div class="split">|</div>                            
                    <div class="cot3" align="left">
                        <div><b>Tên thành viên:</b> <%#Eval("vMemberName") %></div>
                        <div><b>Tên đăng nhập:</b> <%#Eval("vMemberAccount") %></div>
                        <div><b>Ngày sinh:</b> <%#((DateTime)Eval("dMemberBirthday")).ToString("dd/MM/yyyy")%></div>
                        <div><b>Email:</b> <%#Eval("vMemberEmail")%></div>
                        <div><b>Điện thoại:</b> <%#Eval("vMemberPhone")%></div>                        
                        <div><b>Địa chỉ:</b> <%#Eval("vMemberAddress")%></div>
                        <div><b>Số lần đăng nhập:</b> <%# Eval("iMemberTotalLogin")%></div>
                    </div>  
                    <div class="split">|</div>                            
                    <div class="cot4" align="center">&nbsp;</div>
                    <div class="split">|</div>                            
                    <div class="cot5" align="center"><%#TimeExtension.FormatTime(Eval("dMemberCreatedate"),"dd/MM/yyyy HH:mm:ss")%></div>
                    <div class="split">|</div>
                    <div class="cot6" align="center"><%#GetStatusMember(Eval("iMemberIsApproved").ToString(), Eval("iMemberIsLockedOut").ToString())%></div>             
                    <div class="split">|</div>       
                    <div class="fr tool pr5">
                        <%--<a href="javascript:void(0)" onclick="NewWindow_('cms/admin/Moduls/Member/List/PopUp/SendMesAlert.aspx?imid=<%#Eval("IMID")%>','ImageList','800','600','yes','yes')" class="" title="Gửi thông báo tới thành viên"><span class="iconEmailAlert">&nbsp;</span></a>--%>
                        <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Click để khóa tài khoản này" CommandName="lock" CommandArgument='<%#Eval("IMID").ToString() %>'><span class="iconLock"><!----></span></asp:LinkButton>
                        <asp:LinkButton ID="LbUpdate" runat="server" ToolTip="Click để thay đổi thông tin thành viên" CommandName="edit" CommandArgument='<%#Eval("IMID").ToString() %>'><span class="iconEdit"><!----></span></asp:LinkButton>
                        <asp:LinkButton ID="LbDelete" runat="server" ToolTip="Click để xóa thành viên" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa thành viên này?')" CommandName="delete" CommandArgument='<%#Eval("IMID").ToString() %>'><span class="iconDelete"><!----></span></asp:LinkButton>
                    </div>
                    <div class="cbh0"><!----></div>                        
                </div>                
            </ItemTemplate>
            <SeparatorTemplate>
                <div class="spaceRowItem"><!----></div>  
            </SeparatorTemplate>
        </asp:Repeater>
    </div>    
    <div class="cb h25"><!----></div>
    
<div id="FooterRightControl">
    <div class="pdFooterR">
        <div class="ColPagging"><div class="AdminPagging"><asp:Literal ID="LtPagging" runat="server"></asp:Literal></div></div>
        <div class="ColShowItem">            
            <div class="TextShow">Hiển thị</div>
            <div class="BoxShow">
                <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px" 
                    Height="19px" CssClass="TextInBox" AutoPostBack="True" 
                    onselectedindexchanged="DdlListShowItem_SelectedIndexChanged">
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="cb"><!----></div>
        </div>        
        <div class="cbh0"><!----></div>
    </div>
</div>    

    <div id="MemberPlaceSearch">
        <div class="frame">
            <div class="frame2">
                <div class="fl pr10"><asp:TextBox ID="tbEmail" runat="server" placeholder="Email"></asp:TextBox></div>
                <div class="fl pr10"><asp:TextBox ID="tbKey" runat="server" placeholder="Tài khoản, tên thành viên"></asp:TextBox></div>                
                <div class="fr">
                    <asp:LinkButton ID="ltrSearch" runat="server" CssClass="lbtSearch" onclick="LbSearch_Click">&nbsp;</asp:LinkButton>
                </div>
                <div class="cb"><!----></div>
            </div>
        </div>
    </div>    
</div>

<script type="text/javascript">
$(window).load(function () {
    var height = ($("#ListMember").outerHeight() + $("#MemberPlaceSearch").outerHeight());
    $(".PositionLeftControl").css("height", height + "px");
    $(".PositionRightControl").css("height", height + "px");
});
$(window).scroll(function () {
    if (($("#MemberPlaceSearch").offset().top + $("#MemberPlaceSearch").outerHeight()) > ($("#AdmFooter").offset().top + 20))
        $("#MemberPlaceSearch").css("bottom", "43px");

    if (($("#MemberPlaceSearch").offset().top + $("#MemberPlaceSearch").outerHeight()) <= ($("#AdmFooter").offset().top - 20))
        $("#MemberPlaceSearch").css("bottom", "0");
});
</script>