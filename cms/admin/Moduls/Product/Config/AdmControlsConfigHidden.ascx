<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsConfigHidden.ascx.cs" Inherits="cms_admin_Product_Controls_AdmControlsConfigurationHidden" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Product/Config/AdmControlsConfigHidden/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<div id="AdmControlsConfigHidden">
    <div class="cb h10"><!----></div>
    <div class="caution">
        <b>Chú ý:</b><br />
        Các cấu hình trong mục này chỉ sử dụng trong quá trình xây dựng website. Bất kỳ thay đổi nào cũng có thể ảnh hưởng tới hoạt động của website.
        <b>Bạn nên cân nhắc trước khi thay đổi bất kỳ thông tin nào trong mục này.</b><br />
        Xin cảm ơn!
    </div>
    <asp:HiddenField ID="hdIgid" runat="server" Value=""/>
    <div id="AddPictureToItems">
    <div class="ffTahoma fs12">        
        <asp:Literal ID="ltrName" runat="server"></asp:Literal>
        <asp:Panel ID="pnList" runat="server">
        <div class='fwb pb10 pt10'>
            Danh sách các trường thông tin sản phẩm:            
        </div>
        <div class='pb5'>
            <span class='iconCreate'><!----></span>
            <asp:LinkButton ID="btInsert" runat="server" ToolTip="Click để thêm mới trường" CssClass="lbtInsert" onclick="btInsert_Click">Thêm trường</asp:LinkButton>
        </div>
        <div class="bcccc pt5 pb5 bdas fwb">
            <div class='fl w200 pl5 bdrs'>
                Tên trường
            </div>
            <div class='fl w200 pl5 bdrs'>
                Mã trường
            </div>   
            <div class='fl w100 tac bdrs'>
                Thứ tự
            </div>
            <div class='fl w100 tac bdrs'>
                Trạng thái
            </div>
            <div class='fr pr5'>
                Công cụ
            </div>
            <div class='cb'><!----></div>
        </div>
        <div class="bdas">
            <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
                <ItemTemplate>
                    <div class='pt5 pb5 bdbs'>
                        <div class='fl w200 pl5'>
                            <%#Eval(TatThanhJsc.Columns.GroupsColumns.VgnameColumn).ToString() %>
                        </div>
                        <div class='fl w200 pl5 bdls bdrs'>
                            <%#Eval(TatThanhJsc.Columns.GroupsColumns.VgdescColumn).ToString() %>
                        </div>            
                        <div class='fl w100 bdrs tac'>
                            <%#Eval(TatThanhJsc.Columns.GroupsColumns.IgorderColumn).ToString()%>
                        </div>
                        <div class='fl w100 bdrs tac'>                            
                            <asp:LinkButton ID="LinkButton4" runat="server" CommandName="EditEnable" CommandArgument='<%#Eval("igid").ToString() %>' ToolTip="Click vào để thay đổi trạng thái">                                
                                <div class="EnableIcon<%#Eval(TatThanhJsc.Columns.GroupsColumns.IgenableColumn).ToString()%>"><!----></div>
                            </asp:LinkButton>
                        </div>
                        <div class='fr'>
                            <div class='IconTool'>
                                <asp:LinkButton ToolTip="Click để xóa mục đang chọn" ID="lnk_delete" runat="server" CommandName="delete" CommandArgument='<%#Eval("igid").ToString() %>' OnClientClick="return confirm('Chú ý: xoá trường này sẽ xoá toàn bộ dữ liệu của sản phẩm về trường này.');"><span class='iconDelete'><!----></span></asp:LinkButton>
                            </div>
                            <div class='IconTool'>
                                <asp:LinkButton ToolTip="Click để thay đổi thông tin" ID="lnk_update" runat="server" CommandName="edit" CommandArgument='<%#Eval("igid").ToString() %>'><span class='iconEdit'><!----></span></asp:LinkButton>
                            </div>                            
                        </div>
                        <div class='cb'><!----></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>            
        </div>        
        </asp:Panel>
        <asp:Panel ID="pnInsert" runat="server" Visible="false">
        <div class='fwb pb15 pt10'>
            <asp:Literal ID="ltrInsertUpdate" runat="server"></asp:Literal>
        </div>        
        <div>
            <div class='fl w120'>Tên trường</div>
            <div class='fl'>
                <asp:TextBox ID="tbName" Width="250px" runat="server"></asp:TextBox>                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="*" ControlToValidate="tbName" 
                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator> 
            </div>
            <div class='cb h5'><!----></div>
        </div>     
        <div>
            <div class='fl w120'>Mã trường</div>
            <div class='fl'>
                <asp:TextBox ID="tbKey" Width="250px" runat="server"></asp:TextBox>                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="*" ControlToValidate="tbKey" 
                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator> 
            </div>
            <div class='cb h5'><!----></div>
        </div>     
        <div>
            <div class='fl w120'>Thứ tự</div>
            <div class='fl'>
                <asp:TextBox ID="tbOrder" Width="100px" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ErrorMessage=" Vui lòng nhập số tự nhiên" ControlToValidate="tbOrder" 
                    Display="Dynamic" SetFocusOnError="True" ValidationExpression="(\d)*"></asp:RegularExpressionValidator>
            </div>
            <div class='cb h5'><!----></div>
        </div>
        <div>
            <div class='fl w120'>Dùng TextEditor</div>
            <div class='fl'>
                <asp:DropDownList ID="ddlTextEditor" runat="server" Width="105px">
                    <asp:ListItem Text="Không" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Có" Value="1"></asp:ListItem>                    
                </asp:DropDownList>
            </div>
            <div class='cb h5'><!----></div>
        </div>
        <div>
            <div class='fl w120'>Trạng thái</div>
            <div class='fl'>
                <asp:DropDownList ID="ddlStatus" runat="server" Width="105px">
                    <asp:ListItem Text="Hiển thị" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Không hiển thị" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class='cb h5'><!----></div>
        </div>
        <div class='pt10'>
            <asp:Button ID="btOK" runat="server" Text="Đồng ý" Width="100px" onclick="btOK_Click" />
            <asp:Button ID="btCancel" runat="server" Text="Huỷ" Width="100px" 
                CausesValidation="false" onclick="btCancel_Click" />
        </div>
        </asp:Panel>
    </div>
    </div>
</div>