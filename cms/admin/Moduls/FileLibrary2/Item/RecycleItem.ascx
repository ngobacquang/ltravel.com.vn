<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecycleItem.ascx.cs" Inherits="cms_admin_Moduls_FileLibrary2_Item_RecycleItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server"><link href="~/cms/admin/Moduls/FileLibrary2/Item/ControlItem/_cs.css" rel="stylesheet" type="text/css" /></cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_time" runat="server" />
<div id="admitem">
    <div class="BgTabTool">        
        <a href="javascript:DeleteRecListItems('<%=pic %>')" class="LinkDelete"><%=Developer.FileLibrary2Keyword.Xoa%></a>                   
        <div class="right dn">            
            <div class="fl pr5">
                <asp:TextBox ID="txt_key" runat="server" Width="190px" height="16px" CssClass="TxtInBox"></asp:TextBox>
            </div>
            <div class="fl pr5">
                <asp:DropDownList ID="ddl_group_ontab" runat="server" Width="190px" height="20px" CssClass="TxtInBox"></asp:DropDownList>
            </div>            
            <div class="fl pr5"><a href="#" class="BgButtonSearch">&nbsp;</a></div>            
            <div class="cb"><!----></div>
        </div>        
    </div>

    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5" align="center"><input id="checkAll" type="checkbox" onchange="CheckAllCheckBox('CbItem',this)"/></div>
        <div class="split">|</div>                    
        <div class="cot2" align="left">        
            <asp:LinkButton ID="lbtName" runat="server" onclick="lbtName_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.FileLibrary2Keyword.TieuDe%></asp:LinkButton>
        </div>
        <div class="split">|</div>                    
        <div class="cot3">
            <asp:LinkButton ID="lbtDate" runat="server" onclick="lbtDate_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.FileLibrary2Keyword.NgayDang %></asp:LinkButton>
        </div>                
        <div class="split">|</div>                    
        <div class="cot4">
            <asp:LinkButton ID="lbtView" runat="server" onclick="lbtView_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.FileLibrary2Keyword.LuotXem%></asp:LinkButton>
        </div>                
        <div class="split">|</div>                    
        <div class="cot5">
            <asp:LinkButton ID="lbtStatus" runat="server" onclick="lbtStatus_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này"><%=Developer.FileLibrary2Keyword.TrangThai %></asp:LinkButton>
        </div>                        
        <div class="split">|</div>                    
        <div class="fr pr5"><%=Developer.FileLibrary2Keyword.CongCu %></div>                    
        <div class="cb"><!----></div>
    </div>
    
    <div align="center" class="content">
        <asp:Repeater ID="rp_mn_users" runat="server" onitemcommand="rp_mn_users_ItemCommand">
            <ItemTemplate>
                <div id="Item-<%#Eval("IID").ToString()%>">
                    <div class="bgItem">
                        <div class="cot1"><input id="CbItem_<%#Eval("IID").ToString() %>" type="checkbox" /></div>                            
                        <div class="split">|</div>                            
                        <div class="cot2" align="left">
                            <div class="fl">
                                <%#TatThanhJsc.Extension.ImagesExtension.GetImage(pic, Eval("VIIMAGE").ToString(), "", "SizeImage", true, true, Eval("VICONTENT").ToString())%>
                            </div>
                            <div>
                                <%#Eval("VITITLE").ToString() %>
                            </div>
                            <div class="cb"><!----></div>
                        </div>                            
                        <div class="split">|</div>                            
                        <div class="cot3"><%#TatThanhJsc.Extension.TimeExtension.FormatTime(Eval("DCREATEDATE"),"dd/MM/yyyy - HH:mm")%></div>
                        <div class="split">|</div>                            
                        <div class="cot4" align="center">
                            <%#Eval("IITOTALVIEW").ToString()%>
                        </div>
                        <div class="split">|</div>                            
                        <div class="cot5" align="center">
                            <a id="nc<%#Eval("IID").ToString()%>" href="javascript:UpdateEnableItem(<%#Eval("IID").ToString()%>)" class="EnableIcon<%#Eval("IIENABLE").ToString()%>">&nbsp;</a>
                        </div>
                        <div class="split">|</div>                            
                        <div class="fr tool pr5">
                            <a href="javascript:RestoreItem('<%#Eval("IID").ToString()%>','<%#Eval("VITITLE").ToString()%>')"><span class='iconRestore'><!----></span></a>
                            <a href="javascript:DeleteRecItem('<%#Eval("IID").ToString()%>','<%#Eval("VITITLE").ToString()%>','<%=pic %>')"><span class='iconDelete'><!----></span></a>
                        </div>
                        <div class="cbh0"><!----></div>                        
                    </div>
                </div>          
            </ItemTemplate>
            <SeparatorTemplate><div class="vien"><!----></div></SeparatorTemplate>
        </asp:Repeater>
    </div>
    <div class="cb h25"><!----></div>
    <div id="FooterRightControl">
        <div class="pdFooterR">
            <div class="ColShowItem">
                <div class="TextShow">Hiển thị</div>
                <div class="BoxShow">
                    <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px" Height="19px" CssClass="TextInBox" onselectedindexchanged="DdlListShowItem_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="cb"><!----></div>
            </div>
            <div class="ColPagging"><div id="AdminPagging"><asp:Literal ID="LtPagging" runat="server"></asp:Literal></div></div>
            <div class="cbh0"><!----></div>
        </div>
    </div>
</div>
