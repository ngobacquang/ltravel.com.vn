/* Demo css và html (phần css thường đã được để sẵn ở main.scss)
<style>
    .tabs-content .tab-content{display:none}
    .tabs-content .tab-content.active{display:block}
</style>
    
<div class="tabs-wrap">        
    <div class="tabs">
        <a href="#" class="tab active" data-tab="tab-1">Tab 1</a>
        <a href="#" class="tab" data-tab="tab-2">Tab 2</a>
        <a href="#" class="tab" data-tab="tab-3">Tab 3</a>
    </div>
    <div class="tabs-content">
        <div class="tab-content active" data-tab="tab-1">
            Nội dung tab 1
        </div>
        <div class="tab-content" data-tab="tab-2">
            Nội dung tab 2
        </div>
        <div class="tab-content" data-tab="tab-3">
            Nội dung tab 3
        </div>  
    </div>
</div>
 */

$(".tabs-wrap").each(function () {
    var $this = $(this);

    $(".tabs .tab", $this)
        .click(function(event) {
            event.preventDefault();

            var dataTab = $(this).attr("data-tab");

            $(".tabs .tab", $this).removeClass("active");
            $(".tabs-content .tab-content", $this).removeClass("active");

            $(".tabs .tab[data-tab='"+dataTab+"']", $this).addClass("active");
            $(".tabs-content .tab-content[data-tab='" + dataTab + "']", $this).addClass("active");

            //Hủy slick và gọi lại slick cho các khối có .slick-slider trong tab, thuộc tính lấy từ data-slick
            $(".tabs-content .tab-content[data-tab='" + dataTab + "'] .slick-slider", $this).slick("unslick").slick();;
        });
});



$(".tab-expaned-wrap").each(function () {
    var $this = $(this);

    $(".tab", $this)
        .click(function (event) {
            event.preventDefault();

            $this.toggleClass("expanded");

            if ($this.hasClass("expanded")) {
                //Hủy slick và gọi lại slick cho các khối có .slick-slider trong tab, thuộc tính lấy từ data-slick
                $(".tab-content .slick-slider", $this)
                    .slick("unslick")
                    .slick();;              
            }
        });
});