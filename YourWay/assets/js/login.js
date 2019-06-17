function login(f) {
    let user = f.user.value;
    let pass = f.password.value;
    let admin;
    if (f.admin) {
        admin = true;
    }
    else {
        admin = false;
    }
    if (user != "" && pass != "") {
        $(".cmp-login .contentform .spinner").show();
        $(".cmp-login .contentform .error").hide();
        $.ajax({
            method: "POST",
            url: "../../../php/admin/actions/login.php",
            data: {
                user: user,
                password: pass,
                admin: admin
            },
            success: function (data) {
                console.log(data)
                if (data == "success") {
                    if (admin == true) {
                        window.location.href = "../admin/admin.php";
                    }
                    else {
                        window.location.href = "../driver/driver.php";
                    }
                }
                else {
                    $(".cmp-login .contentform .spinner").hide();
                    $(".cmp-login .contentform .error").show();
                    return false;
                }
            }
        });
    }
    else {
        $(".cmp-login .contentform .error").show();
    }
    return false;
}