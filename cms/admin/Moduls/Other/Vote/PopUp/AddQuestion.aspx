<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddQuestion.aspx.cs" Inherits="cms_admin_Moduls_Other_Vote_PopUp_AddQuestion" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý danh sách câu trả lời</title>
    
    <script>
        var WebsiteUrl = '<%=UrlExtension.WebisteUrl %>';
    </script>
    <script src="../../../../js/jquery-1.4.2.min.js"></script>
    
    
    <script src="../../../../js/Common.js"></script>

    <script src="../../../../js/jAleart/jquery.alerts.js"></script>
    <link href="../../../../js/jAleart/jquery.alerts.css" rel="stylesheet" />

    <script src="../../../../Ajax/Items/_Items.js"></script>
    <script src="../../../../js/TAleart.js"></script>
    <script src="../../../../js/TCheckBox.js"></script>
    <script src="../../../../js/TWindow.js"></script>
    
    <link href="AddQuestion/_cs.css" rel="stylesheet" />
    <link href="../../../../cs/Icon.css" rel="stylesheet" />


</head>
<body>
    <form id="form1" runat="server">
    <div id="AddQuestion">
        <asp:HiddenField ID="hdInsertUpdate" runat="server" />
        <asp:HiddenField ID="HdId" runat="server" />

        <asp:Literal ID="LtQuestion" runat="server"></asp:Literal>
        <asp:Panel ID="pnList" runat="server">
        <div class="TtlList">Quản lý danh sách câu trả lời</div>
        <div class="bdList">
            
            <div class="tool">
                <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Thêm mới câu trả lời" OnClick="LinkButton1_Click" CssClass="LinkCreate">Thêm mới câu trả lời</asp:LinkButton>
                &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                <a href="javascript:DeleteRecListItems('')" class="LinkDelete">Xóa câu trả lời đang chọn</a>                   
            </div>
            <div class="bTab">
                <div class="Colcb pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)"/></div>
                <div class="sp">|</div>
                <div class="Col1"><b>Câu trả lời</b></div>
                <div class="sp">|</div>
                <div class="Col2" align="center"><b>Màu sắc</b></div>
                <div class="sp">|</div>
                <div class="Col3" align="center"><b>Số lượt bình chọn</b></div>
                <div class="sp">|</div>
                <div class="Col4" align="center"><b>Trạng thái</b></div>
                <div class="sp">|</div>
                <div class="Col5"><b>Công cụ</b></div>
                <div class="cb"><!----></div>
            </div>
            <div class="content">
                <asp:Repeater ID="rp_mn_users" runat="server" onitemcommand="rp_mn_users_ItemCommand">
                    <ItemTemplate>
                        <div class="Item" id='Item-<%#Eval("IID").ToString()%>' align="center">
                            <div class="Colcb"><input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>                            
                            <div class="sp">|</div>                            
                            <div class="Col1" align="left"><%#Eval("VITITLE").ToString() %></div>                            
                            <div class="sp">|</div>                            
                            <div class="Col2">x</div>
                            <div class="sp">|</div>
                            <div class="Col3">x</div>
                            <div class="sp">|</div>
                            <div class="Col4" align="center">
                                <a id='nc<%#Eval("IID").ToString()%>' href="javascript:UpdateEnableItem(<%#Eval("IID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString()%>">&nbsp;</a>                                
                            </div>
                            <div class="sp">|</div>                        
                            <div class="Col5 pr5">                            
                                <asp:LinkButton ID="LbEdit" runat="server" CssClass="iconEdit" CommandName="edit" CommandArgument='<%#Eval("IID").ToString()%>'>&nbsp;</asp:LinkButton>
                                <a href="javascript:DeleteRecItem('<%#Eval("IID").ToString()%>','<%#Eval("VITITLE").ToString()%>')"><span class='iconDelete'><!----></span></a>
                            </div>
                            <div class="cb"><!----></div>                        
                        </div>          
                    </ItemTemplate>
                    <SeparatorTemplate><div class="vien"><!----></div></SeparatorTemplate>
                </asp:Repeater>
            </div>
            </asp:Panel>
        </div>
    
        
        <asp:Panel ID="pnShorcut" runat="server" Visible="False">
            <div class="TtlList">Thêm câu trả lời mới</div>
                <div class="bdList">
                    <div class="pdForm">
                        <div>Câu trả lời: <asp:TextBox ID="TbRep" runat="server" Width="300px"></asp:TextBox></div>    
                        <div class="cb10"><!----></div>
                        <div>Trạng thái: <asp:CheckBox ID="cbEnable" runat="server" Text="(click chọn để hiển thị)" /></div>
                        <div class="cb10"><!----></div>
                        <div class="pdbtn"><asp:Button ID="BtnSave" runat="server" Text="Đồng ý" OnClick="BtnSave_Click" /></div>
                    </div>
                </div>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
