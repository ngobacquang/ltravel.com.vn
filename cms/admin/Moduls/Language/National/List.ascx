<%@ Control Language="C#" AutoEventWireup="true" CodeFile="List.ascx.cs" Inherits="cms_admin_Moduls_Language_National_List" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.LanguageModul" %>
<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />
<div id="AdmControlsLanguageNational">
    <div class="PositionRightControl">
        <div class="BgLanguageNationalTabTool">
            <div class="pdTool">
                <div><asp:LinkButton CssClass="LinkCreate" ID="lnk_create_account" runat="server" onclick="lnk_create_account_Click">Tạo ngôn ngữ mới</asp:LinkButton></div>
                <div class="SpaceCol"><div class="SpaceLinkTabCreate">&nbsp;</div></div>                
                <div class="cbh0"><!----></div>
            </div>
        </div>
        <div class="cbh0"><!----></div>
        <div class="BgLanguageNationalTabTitle" align="center">
            <div class="FormatCheckBox" align="right"><asp:CheckBox ID="chk_list" 
                    runat="server" AutoPostBack="true" oncheckedchanged="chk_list_CheckedChanged" /></div>
            <div class="FomratNationalSpaceCol">|</div>
            <div class="FormatFlagNational">Cờ quốc gia</div>
            <div class="FomratNationalSpaceCol">|</div>
            <div class="FormatNational" align="left">
                <asp:LinkButton ID="lbtName" runat="server" CssClass="NameNational" ToolTip="Click để sắp xếp theo tên quốc gia">Tên ngôn ngữ</asp:LinkButton>
            </div>
            <div class="FomratNationalSpaceCol">|</div>
            <div class="FormatNationalOrder">Thứ tự</div>
            <div class="FomratNationalSpaceCol">|</div>
            <div class="FormatNationalStatus">Trạng thái</div>
            <div class="FomratNationalSpaceCol">|</div>
            <div class="FormatNationalTool">Công cụ</div>
            <div class="cbh0"><!----></div>
        </div>
        <div class="cbh0"><!----></div>
        <div class="BgContainLanguageNational">
            <asp:Repeater ID="RpListLanguageNationals" runat="server" 
                onitemcommand="RpListLanguageNationals_ItemCommand">
                <ItemTemplate>
                    <div class="FormatCellItem">
                        <div class="pdCellItem">
                            <div class="FormatCheckBox" align="right"><asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("iLanguageNationalId") %>'/></div>
                            <div class="FomratNationalSpaceCol">|</div>
                            <div class="FormatNationalFlag" align="center"><%#ImagesExtension.GetImage(FolderPic.Language, Eval("nLanguageNationalFlag").ToString(), Eval("nLanguageNationalFlag").ToString(),"",false,false,"") %>&nbsp;</div>
                            <div class="FomratNationalSpaceCol">|</div>
                            <div class="LanguageNationalName"><%#Eval("nLanguageNationalName").ToString() %></div>
                            <div class="FomratNationalSpaceCol">|</div>
                            <div class="FormatOrder" align="center"><asp:TextBox ID="TbOrder" runat="server" Text='<%#Eval("nLanguageNationalDesc").ToString()%>' ToolTip='<%#Eval("iLanguageNationalId").ToString()%>'  CssClass="TextInBox" AutoPostBack="true" OnTextChanged="TextChanged"></asp:TextBox></div>
                            <div class="FomratNationalSpaceCol">|</div>
                            <div class="FormatStatus" align="center">
                                <asp:LinkButton ID="LbChangeStatus" runat="server" CommandName="EditStatus" CommandArgument='<%#Eval("iLanguageNationalId").ToString() %>' ToolTip="Click vào để thay đổi trạng thái">
                                <div class="EnableIcon<%#Eval("iLanguageNationalEnable").ToString()%>"><!----></div>
                                </asp:LinkButton>
                            </div>
                            <div class="FomratNationalSpaceCol">|</div>
                            <div class="LanguageNationalTool">                                
                                <div class="PdIconEdit"><asp:LinkButton ID="LnkUpdate" runat="server" CommandName="edit" CommandArgument='<%#Eval("iLanguageNationalId").ToString() %>' ToolTip="Click vào để thay đổi thông tin ngôn ngữ này"><div class="ImageEditRecord">&nbsp;</div></asp:LinkButton></div>
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