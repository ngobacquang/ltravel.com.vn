<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCartDetail.aspx.cs" Inherits="cms_admin_TrainTicket_ShowTrainTicketControl_ViewCart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết đơn hàng</title>   
    <link href="ViewCartDetail/_cs.css" rel="stylesheet" type="text/css" />
</head>       
<body>
    <form id="form1" runat="server">
    <div class="ffTahoma fs12 w850 ma">
        <div>
            <%=TatThanhJsc.Extension.SettingsExtension.GetSettingKey(TatThanhJsc.TrainTicketModul.SettingKey.NoiDungDauDonHang,TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin()) %>
        </div>
        <div class='cb fs24 tac fwb pt15 pb5'>
            ĐƠN ĐẶT HÀNG
        </div>
        <div class='date tac pb15'>
            Mã đơn hàng: <asp:Literal ID="ltrMaDonHang" runat="server"></asp:Literal> - Ngày <%=DateTime.Now.Day %> tháng <%=DateTime.Now.Month %> năm <%=DateTime.Now.Year %>
        </div>
        <div class="thongTinKH">
            <asp:Literal ID="ltrThongTinKhachHang" runat="server"></asp:Literal>        
        </div>
        <div class='cb h20'><!----></div>
        <table cellpadding="0" cellspacing="0" class="bda">
            <tr>
                <td class="bdr pt5 pb5 tac fwb" width="5%">STT</td>
                <td class="bdr pt5 pb5 tac fwb" width="25%">Tên vật tư</td>
                <td class="bdr pt5 pb5 tac fwb" width="20%">Thông số</td>
                <td class="bdr pt5 pb5 tac fwb" width="10%">Số lượng</td>
                <td class="bdr pt5 pb5 tac fwb" width="10%">Đơn giá (VND)</td>
                <td class="pt5 pb5 tac fwb" width="10%">Thành tiền (VND)</td>
            </tr>            
            <asp:Repeater ID="rptList" runat="server">
                <ItemTemplate>
                <tr>
                    <td class="bdr bdt pt5 pb5 tac" width="5%"><%#++sott %></td>
                    <td class="bdr bdt pt5 pb5 tal pl5" width="25%"><%#Eval(TatThanhJsc.Columns.SubitemsColumns.VstitleColumn) %></td>
                    <td class="bdr bdt pt5 pb5 tal pl5" width="20%"><%#Eval(TatThanhJsc.Columns.SubitemsColumns.VscontentColumn) %></td>
                    <td class="bdr bdt pt5 pb5 tac" width="10%"><%#TatThanhJsc.Extension.NumberExtension.FormatNumber(Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn).ToString())%></td>
                    <td class="bdr bdt pt5 pb5 tar pr5" width="10%"><%#TatThanhJsc.Extension.NumberExtension.FormatNumber(Eval(TatThanhJsc.Columns.SubitemsColumns.VsurlColumn).ToString())%></td>
                    <td class="bdt pt5 pb5 tar pr5" width="10%"><%#ThanhTien(Eval(TatThanhJsc.Columns.SubitemsColumns.VsatuthorColumn).ToString(), Eval(TatThanhJsc.Columns.SubitemsColumns.VsurlColumn).ToString())%></td>  
                </tr>
                </ItemTemplate>                    
            </asp:Repeater>            
            <tr>
                <td colspan="4"  class="bdr bdt pt5 pb5 tac fwb">Tổng cộng</td>
                <td colspan="2"  class="bdt pt5 pb5 tac fwb"><asp:Literal ID="ltrTotalPrice" runat="server"></asp:Literal></td>
            </tr>
        </table>
        <div class="DocGia pt10 pb10">
        (Bằng chữ: <asp:Literal ID="ltrReadPrice" runat="server"></asp:Literal> đồng chẵn)
        </div>
        <div class='cb'>
            <%=TatThanhJsc.Extension.SettingsExtension.GetSettingKey(TatThanhJsc.TrainTicketModul.SettingKey.NoiDungCuoiDonHang,TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin()) %>
        </div>
    </div>
    </form>
</body>
</html>
