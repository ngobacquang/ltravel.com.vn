<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewsToItems.aspx.cs" Inherits="cms_admin_ModulMain_News_PopUp_Items_AddNewsToItems" ValidateRequest="false"%>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.ProductModul" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm bài viết</title>        
    <script src="../../../../js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../../../js/TCookie.js" type="text/javascript"></script>
    <script src="../../../../js/Common.js" type="text/javascript"></script>
        
    <script type="text/javascript">
        var weburl = '<%=UrlExtension.WebisteUrl %>';         
    </script>

    <link href="AddNewsToItems/_cs.css" rel="stylesheet" type="text/css" />
    <link href="../../../../cs/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="AddNewsToItems">    
        <asp:HiddenField ID="currentIsid" runat="server" />
        <asp:HiddenField ID="hd_img" runat="server" />
        <asp:HiddenField ID="hdOldContent" runat="server" />
    <div class="w960 ma ffTahoma fs12">        
        <asp:Literal ID="ltrName" runat="server"></asp:Literal>
        <asp:Panel ID="pnList" runat="server">
        <div class='fwb pb10 pt10'>
            Danh sách bài viết:                 
        </div>
        <div class='pb5'>
            <span class='ImageCreateRecord'><!----></span>
            <asp:LinkButton ID="btInsert" runat="server" ToolTip="Click để thêm mới bài viết" CssClass="lbtInsert" onclick="btInsert_Click">Thêm bài viết</asp:LinkButton>            
            <div class="cb h10"><!----></div>            
        </div>
        <div class="bcccc pt5 pb5 bdas fwb">
            <div class='fl w100 pl5 bdrs'>
                Ảnh đại diện
            </div>
            <div class='fl w300 pl5 bdrs'>
                Tiêu đề
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
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>            
            <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
                <ItemTemplate>
                    <div class='pt5 pb5 bdbs'>
                        <div class='fl w100 pl5'>                            
                            <%#ImagesExtension.GetImage(FolderPic.Product, Eval(TatThanhJsc.Columns.SubitemsColumns.VsimageColumn).ToString(), "", "", false, false, "")%>&nbsp;
                        </div>
                        <div class='fl w300 pl5 bdls bdrs'>                            
                            <asp:TextBox ID="tbTitle" runat="server" Text='<%#Eval(TatThanhJsc.Columns.SubitemsColumns.VstitleColumn).ToString()%>' ToolTip='<%#Eval("ISID").ToString()%>'  CssClass="TextInBox" TextMode="MultiLine" style="width:90%;height:60px;font-size:12px;resize:none" AutoPostBack="true" OnTextChanged="UpdateTitle"></asp:TextBox>&nbsp;
                        </div>                             
                        <div class='fl w100 bdrs tac'>
                            <asp:TextBox ID="tbOrder" runat="server" Text='<%#Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn).ToString()%>' ToolTip='<%#Eval("ISID").ToString()%>'  CssClass="TextInBox" style="width:70px;font-size:12px" AutoPostBack="true" OnTextChanged="UpdateOrder"></asp:TextBox>
                        </div>
                        <div class='fl w100 bdrs tac'>                            
                            <asp:LinkButton ID="LinkButton4" runat="server" CommandName="EditEnable" CommandArgument='<%#Eval("isid").ToString() %>' ToolTip="Click vào để thay đổi trạng thái">                                
                                <div class="EnableIcon<%#Eval(TatThanhJsc.Columns.SubitemsColumns.IsenableColumn).ToString()%>"><!----></div>
                            </asp:LinkButton>
                        </div>
                        <div class='fr pr5'>                                                        
                            <asp:LinkButton ToolTip="Click để thay đổi thông tin" ID="lnk_update" runat="server" CommandName="edit" CommandArgument='<%#Eval("isid").ToString() %>'><span class='iconEdit'><!----></span></asp:LinkButton>                                                                          
                            <asp:LinkButton ToolTip="Click để xóa mục đang chọn" ID="lnk_delete" runat="server" CommandName="delete" CommandArgument='<%#Eval("isid").ToString() %>' OnClientClick="return confirm('Bạn chắc chắn muốn xóa mục này?');"><span class='iconDelete'><!----></span></asp:LinkButton>                            
                        </div>
                        <div class='cb'><!----></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>            
            </ContentTemplate>
            </asp:UpdatePanel>
        </div>        
        </asp:Panel>
        <asp:Panel ID="pnInsert" runat="server" Visible="false">
        <div class='fwb pb15 pt10'>
            <asp:Literal ID="ltrInsertUpdate" runat="server"></asp:Literal>
        </div>        
        <div>
            <div class='fl w120'>Tiêu đề</div>
            <div class='fl'>
                <asp:TextBox ID="tbName" Width="250px" runat="server"></asp:TextBox>                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="Vui lòng điền tiêu đề bài viết." ControlToValidate="tbName" 
                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator> 
            </div>
            <div class='cb h5'><!----></div>
        </div>
        <div>
            <div class='fl w120'>Mô tả</div>
            <div class='fl'>
                <asp:TextBox ID="tbDesc" runat="server" Width="600px" Height="60px"  TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class='cb h5'><!----></div>
        </div>
        <div>   
            <div class="fl w120">Ảnh đại diện:</div>
            <div class="cotanh">
                <%--Đóng dấu ảnh--%>
                <asp:HiddenField ID="hdLogoImage" runat="server" Value=""/>
                <asp:HiddenField ID="hdViTriDongDau" runat="server" Value=""/>
                <asp:HiddenField ID="hdLeX" runat="server" Value=""/>
                <asp:HiddenField ID="hdLeY" runat="server" Value=""/>
                <asp:HiddenField ID="hdTyLe" runat="server" Value=""/>
                <asp:HiddenField ID="hdTrongSuot" runat="server" Value=""/>
                <%--Đóng dấu ảnh - end --%>    
                <div class="khungThuocTinh psr">
                <div><asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>                
                <div><asp:FileUpload ID="flimg" runat="server" Width="255px" /></div>
                <div>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                        SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
                </div>                
                <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
                <div id="Toogle_ThietLapAnhDaiDien"> <%--Đặt tên div bắt đầu bằng Toogle_ để được khởi tạo trạng thái ẩn hiện bằng js --%>
                    <div class="cb h10"><!----></div>
                    <asp:CheckBox ID="cbDongDauAnh" runat="server" Text="Đóng dấu ảnh"/>
                    <div class="cb h5"><!----></div>
                    <div class="fl">
                        <asp:CheckBox ID="cbHanCheKichThuoc" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện"/>
                        <div class="khungThuocTinh">
                            Rộng <asp:TextBox ID="tbHanCheW" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                            Cao <asp:TextBox ID="tbHanCheH" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
                        </div>
                    </div>
                    <div class="fr">
                        <asp:CheckBox ID="cbTaoAnhNho" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)"/>
                        <div class="khungThuocTinh">
                        Rộng <asp:TextBox ID="tbAnhNhoW" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                        Cao <asp:TextBox ID="tbAnhNhoH" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
                        </div>
                    </div>
                    <div class="cb"><!----></div>  
                </div>
                </div>
            </div>
            <div class="cb h5"><!----></div>
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
            <div class='fl w120'>Trạng thái</div>
            <div class='fl'>
                <asp:DropDownList ID="ddlStatus" runat="server" Width="105px">
                    <asp:ListItem Text="Hiển thị" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Không hiển thị" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class='cb h5'><!----></div>
        </div>
            
        <div>Nội dung bài viết</div>
        <div class="cbh10"><!----></div>
        <div>           
            <CKEditor:CKEditorControl ID="tbContent" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Product"></CKEditor:CKEditorControl>             
        </div>
        <div class="cbh10"><!----></div>            
        <div class='pt10 pb20'>
            <asp:Button ID="btOK" runat="server" Text="Đồng ý" Width="100px" onclick="btOK_Click" />
            <asp:Button ID="btCancel" runat="server" Text="Huỷ" Width="100px" 
                CausesValidation="false" onclick="btCancel_Click" />
        </div>
        </asp:Panel>
    </div>
    <script type="text/javascript">
        InitToggle(); //Khởi tạo trạng thái ẩn hiện cho các khối div có id bắt đầu bằng Toogle_        
    </script>
    </div>
    </form>
</body>
</html>
