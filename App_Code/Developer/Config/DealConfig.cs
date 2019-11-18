/// <summary>
/// Lưu các cấu hình cho modul deal
/// </summary>
public class DealConfig
{
  private string[] values;
  private string[] text;

  public DealConfig()
  {
    text = new string[] { "Giao sản phẩm", "Giao voucher" };
    values = new string[] { "0", "1" };
  }
  /// <summary>
  /// Lưu chuỗi: Giao sản phẩm, Giao voucher,...
  /// </summary>
  public string[] Text
  {
    get { return text; }
  }
  public string[] Values
  {
    get { return values; }
  }

  #region DuyetTin
  public const bool KeyDuyetTin = true;
  #endregion

  public const bool KeyHienThiQuanLyThuocTinhDeal = false;
  public const bool KeyHienThiThuocTinhLocDeal = false;
  public const bool KeyHienThiQuanLyPhanHoiDeal = false;
  public const bool KeyHienThiThongKeBaoCaoDeal = false;
  public const bool KeyHienThiThemNhieuAnhChoDeal = false;
  public const bool KeyHienThiNhieuAnhDealTheoMau = false;
  public const bool KeyHienThiAddNickChoDeal = false;
  public const bool KeyHienThiHangSanXuat = false;

  public const bool KeyHienThiThemNhieuVideoChoDeal = false;
  public const bool KeyHienThiThemNhieuSubitemChoDeal = false;

  public const bool KeyHienThiQuanLySoLuongDeal = false;
  public const bool KeyHienThiQuanLyThoiGianDeal = false;
}