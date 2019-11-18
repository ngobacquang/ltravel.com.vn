namespace Developer.Position
{
  public class CustomerReviewsPosition
  {
    private string[] values;
    private string[] text;

    public CustomerReviewsPosition()
    {
      text = new string[]
      {
        "Nhóm cảm nhận khách hàng trang chủ"
      };
      values = new string[]
      {
        "0"
      };
    }
    public string[] Text
    {
      get { return text; }
    }
    public string[] Values
    {
      get { return values; }
    }
  }
}
