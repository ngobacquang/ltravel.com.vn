<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddSubitemToItems.aspx.cs" Inherits="cms_admin_ModulMain_Video_PopUp_Items_AddSubitemToItems" ValidateRequest="false"%>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.DealModul" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm loại cho deal</title>        
    <script src="../../../../js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../../../js/TCookie.js" type="text/javascript"></script>
    <script src="../../../../js/Common.js" type="text/javascript"></script>
        
    <script type="text/javascript">
        var weburl = '<%=UrlExtension.WebisteUrl %>';         
    </script>

    <link href="AddSubitemToItems/_cs.css" rel="stylesheet" type="text/css" />
    <link href="../../../../cs/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="AddSubitemToItems">    
    <asp:HiddenField ID="currentIsid" runat="server" />
    <div class="w900 ma ffTahoma fs12">        
        <asp:Literal ID="ltrName" runat="server"></asp:Literal>
        <asp:Panel ID="pnList" runat="server">
        <div class='fwb pb10 pt10'>
            Danh sách loại:                 
        </div>
        <div class='pb5'>
            <span class='ImageCreateRecord'><!----></span>
            <asp:LinkButton ID="btInsert" runat="server" ToolTip="Click để thêm mới loại" CssClass="lbtInsert" onclick="btInsert_Click">Thêm từng loại một</asp:LinkButton>            
            <div class="cb h10"><!----></div>            
        </div>
        <div class="bcccc pt5 pb5 bdas fwb">
            <div class='fl w200 pl5 bdrs'>
                Hình ảnh
            </div>
            <div class='fl w200 pl5 bdrs'>
                Tên
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
                        <div class='fl w200 pl5'>                            
                            <%#ImagesExtension.GetImage(FolderPic.Deal, Eval(TatThanhJsc.Columns.SubitemsColumns.VsimageColumn).ToString(), "", "hotelImage", false, false, "")%>&nbsp;
                        </div>
                        <div class='fl w200 pl5 bdls bdrs'>                            
                            <asp:TextBox ID="tbTitle" runat="server" Text='<%#Eval(TatThanhJsc.Columns.SubitemsColumns.VstitleColumn).ToString()%>' ToolTip='<%#Eval("ISID").ToString()%>'  CssClass="TextInBox" TextMode="MultiLine" style="width:180px;height:60px;font-size:12px;resize:none" AutoPostBack="true" OnTextChanged="UpdateTitle"></asp:TextBox>&nbsp;
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
                            <asp:LinkButton ToolTip="Click để xóa mục đang chọn" ID="lnk_delete" runat="server" CommandName="delete" CommandArgument='<%#Eval("isid").ToString() %>' OnClientClick="Thong bao"><span class='iconDelete'><!----></span></asp:LinkButton>                            
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
            <div class='fl w120'>Tên</div>
            <div class='fl'>
                <asp:TextBox ID="tbName" Width="250px" runat="server"></asp:TextBox>                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="Vui lòng điền tên loại." ControlToValidate="tbName" 
                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator> 
            </div>
            <div class='cb h5'><!----></div>
        </div>   

        <div>
            <div class='fl w120'>Mô tả</div>
            <div class='fl'>
                <asp:TextBox ID="tbMoTa" runat="server" TextMode="MultiLine" Width="700px" Height="80px"></asp:TextBox>                
            </div>
            <div class='cb h5'><!----></div>
        </div>   
            
        <div>
            <div class='fl w120'>Giá bán</div>
            <div class='fl'>
                <div>
                    <asp:TextBox ID="tbPrice" runat="server" Width="250px" onkeyup="HienThiGia(this,'giaBan')" onblur="HideList('price')" onfocus="ShowList('price')"></asp:TextBox>
                    <span style="font:bold 13px Arial" id="giaBan"><!----></span>
                </div>
                <div>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                ErrorMessage="Vui lòng nhập giá kiểu số (vd:12 hoặc 12.5)" ControlToValidate="tbPrice" Display="Dynamic" 
                                SetFocusOnError="True" ValidationExpression="(\d)*(\.)?(\d)*"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class='cb h5'><!----></div>
        </div>            
            <div>
                <div class='fl w120'>Giá niêm yết</div>
                <div class='fl'>
                   <div>
                        <asp:TextBox ID="tbPriceOld" runat="server" Width="250px" onkeyup="HienThiGia(this,'giaNiemYet')" onblur="HideList('niemYet')" onfocus="ShowList('niemYet')"></asp:TextBox>
                        <span style="font:bold 13px Arial" id="giaNiemYet"><!----></span>
                    </div>
                    <div>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                    ErrorMessage="Vui lòng nhập giá kiểu số (vd:12 hoặc 12.5)" ControlToValidate="tbPriceOld" Display="Dynamic" 
                                    SetFocusOnError="True" ValidationExpression="(\d)*(\.)?(\d)*"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class='cb h5'><!----></div>
            </div>
            <script type="text/javascript">
                function HienThiGia(idTextBoxGia, idHienThi) {
                    var gia = idTextBoxGia.value;
                    gia = DinhDangGia(gia);
                    document.getElementById(idHienThi).innerHTML = gia;
                }
                function DinhDangGia(number) {
                    if (isNaN(number)) return "<span style='font:normal 12px Arial;color:red'>Giá nhập sai định dạng!</span>";
                    var str = new String(number);

                    var indexOfdot = str.indexOf(".", 0);
                    var phanThapPhan;
                    if (indexOfdot > -1) {
                        phanThapPhan = "," + str.substring(indexOfdot + 1, len);
                        str = str.substring(0, indexOfdot);
                    }

                    var result = "", len = str.length;
                    for (var i = len - 1; i >= 0; i--) {
                        if ((i + 1) % 3 == 0 && i + 1 != len) result += ".";
                        result += str.charAt(len - 1 - i);
                    }

                    if (indexOfdot > -1)
                        result += phanThapPhan;

                    return result;
                }
            </script>

                                      

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
        <div class='pt10'>
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
