<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Moduls_Other_DcLink_Loadcontrol" %>
<%@ Import Namespace="TatThanhJsc.Columns" %>
<div id="DcLink">    
    <div class="searchBox">
        Link cần kiểm tra
        <asp:TextBox ID="tbLink" runat="server" AutoPostBack="True" OnTextChanged="tbLink_TextChanged"></asp:TextBox>
        <asp:Button ID="btCheck" runat="server" Text="Kiểm tra" OnClick="btCheck_Click" />
    </div>
    <div class="searchBox">
        <asp:RadioButton ID="rbNew" Checked="True" runat="server" GroupName="CheckLink" Text="Kiểm tra link mới"/>&nbsp;&nbsp;&nbsp;
        <asp:RadioButton ID="rbDuplicate" runat="server" GroupName="CheckLink" Text="Xem các link đã trùng nhau"/>
    </div>
    <div class="contentBox">
        <table class="formatted">
            <tr>
                <th>TT</th>
                <th>Tiêu đều</th>
                <th>Link</th>
                <th>Loại</th>
                <th>Sửa</th>
            </tr>
            <asp:Repeater ID="rptList" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><%#++count %></td>
                        <td><%#Eval(ItemsColumns.VititleColumn) %></td>
                        <td><%#Eval(ItemsColumns.VISEOLINKSEARCHColumn) %></td>
                        <td><%#(Eval("RowType").ToString()=="Items")?"Bài viết":"Danh mục" %></td>
                        <td><a target="_blank" title="Click để sửa mục này" href="<%#GetEditLink(Eval(ItemsColumns.IidColumn).ToString(),Eval(ItemsColumns.ViappColumn).ToString(),Eval("RowType").ToString()) %>">Sửa</a></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>        
    </div>
</div>