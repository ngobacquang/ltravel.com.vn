<%@ Control Language="C#" AutoEventWireup="true" CodeFile="List.ascx.cs" Inherits="cms_admin_Moduls_Language_Key_List" %>
<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />
<div id="AdmControlsLanguageKey">
    <div class="PositionRightControl">
        <div class="BgLanguageNationalTabTool">
            <div class="pdTool">
                <div><asp:LinkButton CssClass="LinkCreate" ID="lnk_create_account" runat="server" onclick="lnk_create_account_Click">Tạo mã từ khóa mới</asp:LinkButton></div>
                <div class="SpaceCol"><div class="SpaceLinkTabCreate">&nbsp;</div></div>
                <div><asp:LinkButton CssClass="LinkCreate" ID="lnk_delete_user_checked" runat="server" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa mã từ khóa vừa chọn?');" 
                        onclick="lnk_delete_user_checked_Click">Xóa mã từ khóa đang chọn</asp:LinkButton></div>
                <div class="cbh0"><!----></div>
            </div>
        </div>
        <div class="cbh0"><!----></div>
        <div class="BgLanguageKeyTabTitle" align="center">
            <div class="LanguageKeyCheckBox" align="right"><asp:CheckBox ID="chk_list" 
                    runat="server" AutoPostBack="true" oncheckedchanged="chk_list_CheckedChanged" /></div>
            <div class="LanguageKeySpaceCol">|</div>
            <div class="LanguageKeyId">ID</div>
            <div class="LanguageKeySpaceCol">|</div>
            <div class="LanguageKeyCode">Mã từ khóa</div>
            <div class="LanguageKeySpaceCol">|</div>
            <div class="LanguageKeyDesc">Mô tả</div>
            <div class="LanguageKeySpaceCol">|</div>
            <div class="LanguageKeyTool">Công cụ</div>
            <div class="cbh0"><!----></div>
        </div>
        <div class="cbh0"><!----></div>
        <div class="BgContainLanguageKey">
            <asp:Repeater ID="RpListLanguageNationals" runat="server" 
                onitemcommand="RpListLanguageNationals_ItemCommand">
                <ItemTemplate>
                    <div class="LanguageKeyCellItem">
                        <div class="pdLanguageKeyCellItem">
                            <div class="LanguageKeyCheckBox" align="right"><asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("iLanguageKeyId") %>'/></div>
                            <div class="LanguageKeySpaceCol">|</div>
                            <div class="LanguageKeyId"><%#Eval("iLanguageKeyId").ToString() %></div>
                            <div class="LanguageKeySpaceCol">|</div>
                            <div class="LanguageKeyTitle"><%#Eval("nLanguageKeyTitle").ToString() %></div>
                            <div class="LanguageKeySpaceCol">|</div>
                            <div class="LanguageKeyDesc"><%#Eval("nLanguageKeyDesc").ToString() %></div>
                            <div class="LanguageKeySpaceCol">|</div>
                            <div class="LanguageKeyTool">
                                <div class="PdIconDel"><asp:LinkButton ID="LnkDel" runat="server" CommandName="delete" CommandArgument='<%#Eval("iLanguageKeyId").ToString() %>' ToolTip="Click vào để xóa ngôn ngữ này"><div class="ImageDeleteRecord">&nbsp;</div></asp:LinkButton></div>
                                <div class="PdIconEdit"><asp:LinkButton ID="LnkUpdate" runat="server" CommandName="edit" CommandArgument='<%#Eval("iLanguageKeyId").ToString() %>' ToolTip="Click vào để thay đổi thông tin ngôn ngữ này"><div class="ImageEditRecord">&nbsp;</div></asp:LinkButton></div>
                                <div class="cbh0"><!----></div>
                            </div>
                            <div class="cbh0"><!----></div>
                        </div>
                    </div>
                </ItemTemplate>
                <SeparatorTemplate><div class="pdSpaceItem"><div class="SpaceItem"><!----></div></div></SeparatorTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
<div class="ColPrintAndExcel">
    <%@ Register src="../../CommonControls/ExportExcel.ascx" tagname="ExportExcel" tagprefix="uc1" %>
    <uc1:ExportExcel ID="ExportExcel1" runat="server" OnExport="OnExport"/> 
</div>