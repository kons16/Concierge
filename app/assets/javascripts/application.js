// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require data-confirm-modal

window.addEventListener('load', main, false);
function main(e) {
    const jsInitCheckTimer = setInterval(jsLoaded, 1000);

    function sleep(waitMsec) {
        var startMsec = new Date();
        while (new Date() - startMsec < waitMsec);
    }

    function jsLoaded() {
        // 読み込みが終了したとき「入力中です」アナウンスが表示されていたら、1秒後に非表示にする。
        var announce = document.getElementById('on_input_status').innerHTML;
        if(announce == "相手ユーザーが入力中です"){
            sleep(1000); // 1秒 == 1000
            document.getElementById('on_input_status').innerHTML = "";
        }

        // 質問が生成し終わったら「質問を生成しています」メッセージの非表示
    }
}