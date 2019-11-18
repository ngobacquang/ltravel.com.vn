<%@ Control Language="C#" AutoEventWireup="true" CodeFile="List.ascx.cs" Inherits="cms_admin_Moduls_Language_Item_List" %>
<div id="AdmControlsLanguageItem">
    <div class="PositionRightControl">
        <div class="BgLanguageLanguageItem"><div class="TextInContain">Danh sách từ khóa</div></div>
        <div class="cbh0"><!----></div>
        <div class="BgLanguageItemTabTitle" align="center">
            <div class="LanguageItemCode">Mã từ khóa</div>
            <div class="LanguageItemSpaceCol">|</div>
            <div class="LanguageItemWord">Từ khóa</div>
            <div class="LanguageItemSpaceCol">|</div>
            <div class="LanguageItemImage">Ảnh</div>
            <div class="LanguageItemSpaceCol">|</div>
            <div class="LanguageItemTool">Công cụ</div>
            <div class="cbh0"><!----></div>
        </div>
        <div class="cbh0"><!----></div>
        <div class="BgContainLanguageItem">
            <asp:Repeater ID="RpListLanguageNationals" runat="server" onitemcommand="RpListLanguageNationals_ItemCommand" >
                <ItemTemplate>
                    <div class="LanguageItemCellItem">
                        <div class="pdLanguageItemCellItem">
                            <div class="LanguageItemCode"><b><%#Eval("nLanguageKeyTitle").ToString() %></b></div>
                            <div class="LanguageItemSpaceCol">|</div>
                            <div class="LanguageItemWord">
                                <asp:TextBox ID="TbLanguageWord" runat="server" CssClass="TbLanguageWord" ToolTip='<%#Eval("iLanguageKeyId").ToString() %>' Text='<%#GetWordItem(Eval("iLanguageKeyId").ToString()) %>'  AutoPostBack="false" OnTextChanged="TextChanged"></asp:TextBox>
                            </div>
                            <div class="LanguageItemSpaceCol">|</div>
                            <div class="LanguageItemImage">
                                <%#GetImageItem(Eval("iLanguageKeyId").ToString()) %>
                            </div>
                            <div class="LanguageItemSpaceCol">|</div>
                            <div class="tools">
                                <a title="Click để cập nhật ảnh cho mã từ khoá này" class="LanguageItemUpdate" href="javascript:NewWindow_('cms/admin/Moduls/Language/Popup/LanguageItemsImage.aspx?iLanguageKeyId=<%#Eval("iLanguageKeyId")%>','','800','350','yes','yes')">Sửa ảnh</a> | 
                                <asp:LinkButton ID="LnkUpdate" runat="server" CssClass="LanguageItemUpdate" CommandName="edit" CommandArgument='<%#Eval("iLanguageKeyId").ToString() %>' ToolTip="Click vào để thay đổi từ khóa này">Cập nhật</asp:LinkButton>
                            </div>
                            <div class="cbh0"><!----></div>
                        </div>
                    </div>
                </ItemTemplate>
                <SeparatorTemplate><div class="pdSpaceItem"><div class="SpaceItem"><!----></div></div></SeparatorTemplate>
            </asp:Repeater>
        </div>
        <div class='cbh8'><!----></div>
        <div style='text-align:center;'><asp:Button ID="btnUpdateAll" runat="server" Text="Cập nhật" onclick="btnUpdateAll_Click" /></div>
        <div class='cbh8'><!----></div>
    </div>
</div>