<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPictureToItems.aspx.cs" Inherits="cms_admin_ModulMain_Hotel_PopUp_Items_AddPictureToItems" ValidateRequest="false"%>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.TrainTicketModul" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm hình ảnh cho Vé tàu</title>        
    <script src="../../../../js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../../../js/TCookie.js" type="text/javascript"></script>
    <script src="../../../../js/Common.js" type="text/javascript"></script>
        
    <script type="text/javascript">
        var weburl = '<%=UrlExtension.WebisteUrl %>';         
    </script>

    <link href="AddPictureToItems/_cs.css" rel="stylesheet" type="text/css" />
    <link href="../../../../cs/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="AddPictureToItems">    
    <asp:HiddenField ID="currentIsid" runat="server" />
    <div class="w900 ma ffTahoma fs12">        
        <asp:Literal ID="ltrName" runat="server"></asp:Literal>
        <asp:Panel ID="pnList" runat="server">
        <div class='fwb pb10 pt10'>
            Danh sách hình ảnh:                 
        </div>
        <div class='pb5'>
            <span class='ImageCreateRecord'><!----></span>
            <asp:LinkButton ID="btInsert" runat="server" ToolTip="Click để thêm mới hình ảnh" CssClass="lbtInsert" onclick="btInsert_Click">Thêm từng ảnh một</asp:LinkButton>&nbsp;|&nbsp;
            <a class="lbtInsert" href="javascript:Toggle('Toogle_FlashUpload')">Thêm nhiều ảnh cùng lúc</a>
            <div class="cb h10"><!----></div>
            <div id="Toogle_FlashUpload" style="display:none">
            <script type="text/javascript" src="<%=UrlExtension.WebisteUrl%>cms/admin/Moduls/TrainTicket/Item/Popup/AddPictureToItems/swfupload/swfupload.js"></script>
            <script type="text/javascript" src="<%=UrlExtension.WebisteUrl%>cms/admin/Moduls/TrainTicket/Item/Popup/AddPictureToItems/swfupload/handlers.js"></script>
            <script type="text/javascript">
                var swfu;
                window.onload = function () {
                    var iid = '<%=iid %>';
                    var color = '<%=rblColors1.SelectedValue %>';
                    swfu = new SWFUpload({
                        // Backend Settings            
                        upload_url: weburl + "cms/admin/Moduls/TrainTicket/Item/Popup/AddPictureToItems/upload.aspx?iid=" + iid+"&color="+color,
                        post_params: {
                            "ASPSESSID": "<%=Session.SessionID %>"
                        },
                        // File Upload Settings
                        file_size_limit: "5 MB",
                        file_types: "*.jpg; *.jpeg; *.png; *.gif; *.bmp",
                        file_types_description: "Tệp tin hình ảnh",
                        file_upload_limit: "20",    // Zero means unlimited

                        // Event Handler Settings - these functions as defined in Handlers.js
                        //  The handlers are not part of SWFUpload but are part of my website and control how
                        //  my website reacts to the SWFUpload events.
                        //file_dialog_start_handler: fileDialogStart,
                        //file_queued_handler: fileQueued,
                        file_queue_error_handler: fileQueueError,
                        file_dialog_complete_handler: fileDialogComplete,
                        upload_start_handler: uploadStart,
                        upload_progress_handler: uploadProgress,
                        upload_error_handler: uploadError,
                        upload_success_handler: uploadSuccess,
                        upload_complete_handler: uploadComplete,


                        // Button settings
                        button_image_url: weburl + "cms/admin/Moduls/TrainTicket/Item/Popup/AddPictureToItems/swfupload/btupload.png",
                        button_placeholder_id: "spanButtonPlaceholder",
                        button_width: 150,
                        button_height: 150,
                        button_text: '<span class="button">&nbsp;<span class="buttonSmall">&nbsp;</span></span>',
                        button_text_style: '.button { font-family: Helvetica, Arial, sans-serif; font-size: 14pt;} .buttonSmall { font-size: 10pt; }',
                        button_text_top_padding: 1,
                        button_text_left_padding: 5,

                        // Flash Settings
                        flash_url: weburl + "cms/admin/Moduls/TrainTicket/Item/Popup/AddPictureToItems/swfupload/swfupload.swf", // Relative to this file

                        custom_settings: {
                            upload_target: "divFileProgressContainer"
                        },

                        // Debug Settings
                        debug: false
                    });
                }
            </script>            
            <div class="cb h20"><!----></div>            
            <asp:Panel ID="pnMauTrainTicket1" runat="server">            
                <div>
                    <div>Chọn màu Vé tàu</div>
                    <div class='cb h5'><!----></div>
                    <div id="ListColor1">
                        <asp:RadioButtonList ID="rblColors1" runat="server" AutoPostBack="true">
                        </asp:RadioButtonList>
                    </div>
                    <div class='cb h20'><!----></div>
                </div>
            </asp:Panel>            
            <div id="khungUploadTuMayTinh" class="khungupload">
                <div class="tengroupbox">Upload hình ảnh từ máy tính của bạn</div>

		        <div class="tac" id="khungNutUpload">
				    <span id="spanButtonPlaceholder"></span>
                    <div class="cb h20"><!----></div>      
		        </div>                                    
		        <div id="divFileProgressContainer"></div>                
                <div class="tar" id="buttonCancelUpload">
                    <div class="cb h20"><!----></div>                    
                    <a class="btupload" href="javascript:void(0);" onclick="swfu.cancelUpload();">Huỷ upload</a>
                </div>
                <div id="divComplete" style="display:none">
                    <a href="javascript:ReloadPage()">Hoàn thành upload. Click vào đây để tải lại trang và xem kết quả</a>
                    <script type="text/javascript">
                        function ReloadPage() {
                            Toggle('Toogle_FlashUpload');
                            window.location = document.URL;
                        }
                    </script>
                </div>
            </div>
            <div class="cb h10"><!----></div>
            </div>
        </div>
        <div class="bcccc pt5 pb5 bdas fwb">
            <div class='fl w200 pl5 bdrs'>
                Hình ảnh
            </div>
            <div class='fl w200 pl5 bdrs'>
                Tên
            </div>            
            <div class='fl w50 tac bdrs' <%=SetEnableColor() %>>
                Màu
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
                            <%#ImagesExtension.GetImage(FolderPic.TrainTicket, Eval(TatThanhJsc.Columns.SubitemsColumns.VsimageColumn).ToString(), "", "hotelImage", false, false, "")%>&nbsp;
                        </div>
                        <div class='fl w200 pl5 bdls bdrs'>                            
                            <asp:TextBox ID="tbTitle" runat="server" Text='<%#Eval(TatThanhJsc.Columns.SubitemsColumns.VstitleColumn).ToString()%>' ToolTip='<%#Eval("ISID").ToString()%>'  CssClass="TextInBox" TextMode="MultiLine" style="width:180px;height:60px;font-size:12px;resize:none" AutoPostBack="true" OnTextChanged="UpdateTitle"></asp:TextBox>&nbsp;
                        </div>                        
                        <div class='fl w50 tac bdrs' <%#SetEnableColor() %>>
                            <%#GetDivColor(Eval(TatThanhJsc.Columns.SubitemsColumns.VsemailColumn).ToString()) %>&nbsp;
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
        <asp:Panel ID="pnMauTrainTicket" runat="server">            
        <div>
            <div>Chọn màu Vé tàu</div>
            <div class='cb h5'><!----></div>
            <div id="ListColor">
                <asp:RadioButtonList ID="rblColors" runat="server">
                </asp:RadioButtonList>
            </div>
            <div class='cb h20'><!----></div>
        </div>
        </asp:Panel>
        <div>
            <div class='fl w120'>Tên</div>
            <div class='fl'>
                <asp:TextBox ID="tbName" Width="250px" runat="server"></asp:TextBox>                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="Vui lòng điền tên hình ảnh." ControlToValidate="tbName" 
                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator> 
            </div>
            <div class='cb h5'><!----></div>
        </div>     
        <div>            
            <div class="fl w120">Hình ảnh:</div>
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
