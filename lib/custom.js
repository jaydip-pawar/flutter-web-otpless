const OtplessLoginPageVisibility = (visibility) => {
    const OtplessLoginPage = document.getElementById("otpless-login-page");
    OtplessLoginPage.style.display = visibility;
}

const SetOtplessCallback = () => {
    window.otpless = (otplessUser) => {
        console.log(`SetOtplessCallback-${JSON.stringify(otplessUser)}`)
        window.callDartFunction(JSON.stringify(otplessUser));
        OtplessLoginPageVisibility("none");
    }
}

function openLoginPage() {
    SetOtplessCallback();
    const script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "https://otpless.com/auth.js";
    document.head.appendChild(script);
}

const OtplessLoginPageInit = () => {
    const getURLParameter = (paramName, URLString = window.location.href) => {
        const regex = new RegExp('[\\?&]' + paramName + '=([^&#]*)');
        const results = regex.exec(URLString);

        if (results && results.length > 0) {
            return decodeURIComponent(results[1].replace(/\+/g, ' '));
        }
        return '';
    };

    if (getURLParameter('code')) {
        console.log(window.location.href)
        openLoginPage("ef0kpz5g")
    }
}

OtplessLoginPageInit();