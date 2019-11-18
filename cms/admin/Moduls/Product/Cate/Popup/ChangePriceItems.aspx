<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePriceItems.aspx.cs" Inherits="cms_admin_Moduls_Product_Cate_Popup_ChangePriceItems" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cập nhật SIZE cho toàn danh mục</title>
    <link href="ChangePriceItems/css.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="ChangePriceItems">
            <div class="title">Cập nhật SIZE cho toàn danh mục</div>
            <div class="subtitle">
                Tên danh mục <span>
                    <asp:Literal ID="ltName1" runat="server"></asp:Literal></span>
            </div>
            <div class="note">
                Lưu ý: <br/>
                - Các sản phẩm thuộc <b>danh mục</b> con của <span>
                    <asp:Literal ID="ltName2" runat="server"></asp:Literal></span> cũng sẽ được cập nhật SIZE<br/>
            </div>

            <div class="subtitle">Cập nhật SIZE:</div>
            <div class="h20"></div>
            <asp:Panel ID="pnAll" runat="server">
                <div class="text">
                    <div class="pt5">Số loại SIZE</div>
                </div>
                <div class="control mb20">(Nhập số)
                    <asp:TextBox ID="txtNum" runat="server" Width="100px" Text="1"></asp:TextBox>
                    <asp:Button ID="btnSubmit" runat="server" Text="Tạo SIZE" OnClick="btnSubmit_Click" />
                </div>
                <div class="cb"></div>
                <asp:Repeater ID="rpPrice" runat="server">
                    <ItemTemplate>
                        <div class="cbh8">
                            <!---->
                        </div>
                        <div class="text">
                            <div class="pt5"></div>
                        </div>
                        <div class="control">
                            <div class="fl">
                                <div style="margin-right: 10px; float: left">
                                    <asp:TextBox ID="txtTitle" PlaceHolder="Tên SIZE" runat="server" Width="100px"></asp:TextBox>
                                </div>
                            </div>
                            <div>
                              
                            </div>
                            <div class="cb"></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="cbh8"></div>
                <asp:Button ID="btnSubmitAll" runat="server" Text="Cập nhật" OnClick="btnSubmitAll_Click" Enabled="false" />
                <div class="cbh8"></div>
                <asp:Literal runat="server" id="ltResult"></asp:Literal>
            </asp:Panel>


            <div class="cb"></div>
        </div>
    </form>
</body>
</html>
