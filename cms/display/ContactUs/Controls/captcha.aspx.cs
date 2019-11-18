using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Text;

public partial class cms_display_ContactUs_captcha : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string[] fonts = { "Arial Black", "Tahoma" };

    const byte LENGTH = 3;

    // chuỗi để lấy các kí tự sẽ sử dụng cho captcha
    //const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    //const string chars = "36KL01!@ABC78%^&*9GHIJ452MNtuXPQRSTfnUVghijkDEFlmWabopqrsYZOyzvc#$(_+dewx";
    //const string chars = "19CPQRSGH56DE2348AB0FLMNO7IKTUVWXYZJ";
    const string chars = "cpqrsghdeabflmnktuvxyxj";
    using (Bitmap bmp = new Bitmap(80, 29))
    {

      using (Graphics g = Graphics.FromImage(bmp))
      {
        // Tạo nền nhiễu cho ảnh
        HatchBrush brush = new HatchBrush(HatchStyle.Divot, Color.White, Color.Gray);

        g.FillRegion(brush, g.Clip);

        // Lưu chuỗi captcha trong quá trình tạo
        StringBuilder strCaptcha = new StringBuilder();

        Random rand = new Random();
        float curX = 0;//Đánh dấu vị trí x hiện tại đã vẽ đến
        for (int i = 0; i < LENGTH; i++)
        {
          // Lấy kí tự ngẫu nhiên từ mảng chars                    
          string str = chars[rand.Next(chars.Length)].ToString();
          strCaptcha.Append(str);

          // Tạo font với tên font ngẫu nhiên chọn từ mảng fonts
          Font font = new Font(fonts[rand.Next(fonts.Length)], rand.Next(16, 18), FontStyle.Bold | FontStyle.Regular);

          // Lấy kích thước của kí tự
          SizeF size = g.MeasureString(str, font);

          // Vẽ kí tự đó ra ảnh tại vị trí x theo vị trí hiện tại đã vẽ đến, vị trí y ngẫu nhiên
          g.DrawString(str, font, Brushes.WhiteSmoke, curX + 5, rand.Next(-2, 2));
          curX += size.Width;//Cộng thêm độ dộng của ký tự vừa viết vào vị trí x hiện tại (đảm bảo các ký tự vẽ ra không đè lên nhau)
          font.Dispose();
        }

        // Lưu captcha vào session
        Session["captchaContactUs"] = strCaptcha.ToString();

        // Ghi ảnh trực tiếp ra luồng xuất theo định dạng gif
        Response.ContentType = "image/GIF";
        bmp.Save(Response.OutputStream, ImageFormat.Gif);
      }
    }
  }
}