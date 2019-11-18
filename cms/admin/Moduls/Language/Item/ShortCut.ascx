<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCut.ascx.cs" Inherits="cms_admin_Moduls_Language_Item_ShortCut" %>
<%@ Register src="../../CommonControls/DownloadExcelFile.ascx" tagname="DownloadExcelFile" tagprefix="uc1" %>
<div id="AdmImportItem">
    <div class="PositionRightControl">
        <div class="pdControl">
            <div class='tenTrang'>  
                Nhập mã từ khoá từ tệp excel
            </div>
            <div>
                <div class='cotTrai'>
                    <div class='pb15'>Vui lòng làm theo các hướng dẫn phía dưới</div>           
                    <div class='cb h5'><!----></div>          
                    <div class='fl w120'>Chọn tệp Excel</div>
                    <div class='fl'>       
                        <div>
                            <asp:FileUpload ID="fuExcel" runat="server" Width="222px"/>  
                        </div>
                        <div>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                ErrorMessage="Vui lòng chọn đúng tệp excel (có phần mở rộng .xls)" ControlToValidate="fuExcel" Display="Dynamic" 
                                SetFocusOnError="True" ValidationExpression=".+\.xls"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class='cbh20'><!----></div>
                    <div>
                        <asp:Button ID="btOK" runat="server" Text="Đồng ý" Width="100px" 
                            onclick="btOK_Click"/>
                        <asp:Button ID="btCancel" runat="server" Text="Huỷ" CausesValidation="false" Width="100px"
                            onclick="btCancel_Click"/>
                    </div>
                </div>
                <div class='cotPhai'>
                    <div class='fwb pb5'>Hướng dẫn:</div>
                    <div>
                        Tải tệp excel mẫu tại đây: 
                        <uc1:DownloadExcelFile ID="DownloadExcelFile1" runat="server" OnExport="OnExport"/>
                    </div>
                    <div class='fwb'>
                        Chú ý:
                    </div>
                    <div>
                        <span class='fwb'>1.</span> Trong tệp excel có một cột tên là <span class="fwb">"Mã từ khoá"</span>, bạn phải chú ý đảm bảo các mã từ khoá không trùng nhau.
                    </div>                    
                    <div>
                        <span class='fwb'>2.</span> Nếu xuất hiện lỗi: <span class='fwb cRed'>"lỗi định dạng"</span> trong quá trình nhập, hãy lưu lại tệp exel dưới định dạng Excel 97-2003 Workbook(*.xls) <span class='fwb'>(File/Save -> Save as type: Excel 97-2003 Workbook(*.xls))</span> và nhập lại.
                    </div>
                </div>
                <div class='cb h5'><!----></div>
            </div>
        </div>
    </div>
</div>