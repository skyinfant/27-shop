//领取优惠券功能
$(".receiveCoupon").click(function () {
    var couponId = $(this).attr("couponId");
    $.ajax({
        url: ctx + "/coupon/saveUserCoupon/",
        method: "post",
        data: {
            "couponId": couponId,
            "userId": 1
        },
        success: function (result) {
            alert(result)
        },
        error: function () {
            toastr.error("发生错误...");
        }
    })
});