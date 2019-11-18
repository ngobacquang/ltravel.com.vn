<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Destination_Item_ShortCutItemVideo" %>
<%@ Import Namespace="Developer" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>

<asp:HiddenField ID="hdOldContent" runat="server" Value=""/>
<asp:HiddenField ID="hdImage" runat="server"/>
<asp:HiddenField ID="hdTotalView" runat="server"/>
<asp:HiddenField ID="hdGroupsItemId" runat="server"/>
<div id="ShortCutItem" class="InsertPanel InitQuikMenu">
    <div class="head">
        <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal>
    </div>
    <div class="controlBox">
        <div class="row">
            <div class="text"><%= DestinationKeyword.DanhMucCha %></div>
            <div class="control">
                <asp:DropDownList ID="ddlParentCate" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.TieuDe %></div>
            <div class="control">
                <asp:TextBox ID="tbTitle" runat="server" CssClass="tbTitle"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTitle">
                </asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.MoTa %></div>
            <div class="control">
                <asp:TextBox ID="tbDesc" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><div class="pt5"><%=DestinationKeyword.MaChiSe%></div></div>
            <div class="control">
                <asp:TextBox ID="tbYouTube" runat="server" Height="50px" TextMode="MultiLine"></asp:TextBox>
                <div class="pt5">
                    Chú ý: bạn có thể lấy mã từ thanh địa chỉ, từ mã chia sẻ hoặc mã nhúng từ Youtube.
                    <br>VD bạn có thể nhập một trong các dạng sau:
                    <ul>
                        <li>https://www.youtube.com/watch?v=p9FYD1dlw4E</li>
                        <li>http://youtu.be/p9FYD1dlw4E</li>
                        <li>
                            <textarea rows="2" cols="1" style="width:500px;height:50px">&lt;iframe width="853" height="480" src="http://www.youtube.com/embed/p9FYD1dlw4E" frameborder="0" allowfullscreen&gt;&lt;/iframe&gt;</textarea>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện (không nhập sẽ tự lấy ảnh từ video)" LayAnhTuNoiDung="False"/>

        <div class="row">
            <div class="text"><%= DestinationKeyword.NgayDang %></div>
            <div class="control">
                <asp:TextBox ID="tbCreateDate" runat="server" Width="100px"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbCreateDate"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.ThuTu %></div>
            <div class="control">
                <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                                ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbOrder" Display="Dynamic"
                                                SetFocusOnError="True" ValidationExpression="(\d)*">
                </asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.TrangThai %></div>
            <div class="control">
                <asp:CheckBox ID="cbStatus" runat="server" Text="Tích chọn để hiển thị" Checked="true"/>
            </div>
        </div>
        <div class="row">
            <div class="text">&nbsp;</div>
            <div class="control">
                <asp:CheckBox ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
            </div>
        </div>
        <div class="dn">
            <div class="row">
                <%= DestinationKeyword.ChiTiet %>
                <div class="pt10">
                    <CKEditor:CKEditorControl ID="tbContent" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Destination"></CKEditor:CKEditorControl>
                </div>
            </div>
        </div>
        <div class="subHead"><%= DestinationKeyword.ToiUuTimKiem %> </div>

        <div class="row">
            <div class="text"><%= DestinationKeyword.ToiUuTheTieuDe %> (title)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.ToiUuDuongDan %> (url)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.ToiUuTheTuKhoa %> (meta keyword)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= DestinationKeyword.ToiUuTheMoTa %> (meta description)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox>
            </div>
        </div>

        <div class="tac">
            <div class="text textFinish" style="font-size:0">Hoàn thành</div><div class="cb"><!----></div>
            <asp:Button ID="btOK" runat="server" onclick="btOK_Click"/>
            <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" onclick="btCancel_Click" CausesValidation="false"/>
        </div>
        <div class="cbh10"><!----></div>
    </div>
</div>