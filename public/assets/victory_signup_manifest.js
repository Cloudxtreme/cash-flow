jQuery.externalScript=function(e,t){return t=$.extend(t||{},{dataType:"script",cache:!0,url:e}),jQuery.ajax(t)},function(){var e,t,n,r,i,s,o,u,a,f,l,c,h,p,d,v,m,g,y,b=[].slice,w=[].indexOf||function(e){for(var t=0,n=this.length;t<n;t++)if(t in this&&this[t]===e)return t;return-1},E=this;e=jQuery,e.payment={},e.payment.fn={},e.fn.payment=function(){var t,n;return n=arguments[0],t=2<=arguments.length?b.call(arguments,1):[],e.payment.fn[n].apply(this,t)},i=/(\d{1,4})/g,r=[{type:"maestro",pattern:/^(5018|5020|5038|6304|6759|676[1-3])/,format:i,length:[12,13,14,15,16,17,18,19],cvcLength:[3],luhn:!0},{type:"dinersclub",pattern:/^(36|38|30[0-5])/,format:i,length:[14],cvcLength:[3],luhn:!0},{type:"laser",pattern:/^(6706|6771|6709)/,format:i,length:[16,17,18,19],cvcLength:[3],luhn:!0},{type:"jcb",pattern:/^35/,format:i,length:[16],cvcLength:[3],luhn:!0},{type:"unionpay",pattern:/^62/,format:i,length:[16,17,18,19],cvcLength:[3],luhn:!1},{type:"discover",pattern:/^(6011|65|64[4-9]|622)/,format:i,length:[16],cvcLength:[3],luhn:!0},{type:"mastercard",pattern:/^5[1-5]/,format:i,length:[16],cvcLength:[3],luhn:!0},{type:"amex",pattern:/^3[47]/,format:/(\d{1,4})(\d{1,6})?(\d{1,5})?/,length:[15],cvcLength:[3,4],luhn:!0},{type:"visa",pattern:/^4/,format:i,length:[13,14,15,16],cvcLength:[3],luhn:!0}],t=function(e){var t,n,i;e=(e+"").replace(/\D/g,"");for(n=0,i=r.length;n<i;n++){t=r[n];if(t.pattern.test(e))return t}},n=function(e){var t,n,i;for(n=0,i=r.length;n<i;n++){t=r[n];if(t.type===e)return t}},h=function(e){var t,n,r,i,s,o;r=!0,i=0,n=(e+"").split("").reverse();for(s=0,o=n.length;s<o;s++){t=n[s],t=parseInt(t,10);if(r=!r)t*=2;t>9&&(t-=9),i+=t}return i%10===0},c=function(e){var t;return e.prop("selectionStart")!=null&&e.prop("selectionStart")!==e.prop("selectionEnd")?!0:(typeof document!="undefined"&&document!==null?(t=document.selection)!=null?typeof t.createRange=="function"?t.createRange().text:void 0:void 0:void 0)?!0:!1},p=function(t){var n=this;return setTimeout(function(){var n,r;return n=e(t.currentTarget),r=n.val(),r=e.payment.formatCardNumber(r),n.val(r)})},u=function(n){var r,i,s,o,u,a,f;s=String.fromCharCode(n.which);if(!/^\d+$/.test(s))return;r=e(n.currentTarget),f=r.val(),i=t(f+s),o=(f.replace(/\D/g,"")+s).length,a=16,i&&(a=i.length[i.length.length-1]);if(o>=a)return;if(r.prop("selectionStart")!=null&&r.prop("selectionStart")!==f.length)return;i&&i.type==="amex"?u=/^(\d{4}|\d{4}\s\d{6})$/:u=/(?:^|\s)(\d{4})$/;if(u.test(f))return n.preventDefault(),r.val(f+" "+s);if(u.test(f+s))return n.preventDefault(),r.val(f+s+" ")},s=function(t){var n,r;n=e(t.currentTarget),r=n.val();if(t.meta)return;if(n.prop("selectionStart")!=null&&n.prop("selectionStart")!==r.length)return;if(t.which===8&&/\s\d?$/.test(r))return t.preventDefault(),n.val(r.replace(/\s\d?$/,""))},a=function(t){var n,r,i;r=String.fromCharCode(t.which);if(!/^\d+$/.test(r))return;n=e(t.currentTarget),i=n.val()+r;if(/^\d$/.test(i)&&i!=="0"&&i!=="1")return t.preventDefault(),n.val("0"+i+" / ");if(/^\d\d$/.test(i))return t.preventDefault(),n.val(""+i+" / ")},f=function(t){var n,r,i;r=String.fromCharCode(t.which);if(!/^\d+$/.test(r))return;n=e(t.currentTarget),i=n.val();if(/^\d\d$/.test(i))return n.val(""+i+" / ")},l=function(t){var n,r,i;r=String.fromCharCode(t.which);if(r!=="/")return;n=e(t.currentTarget),i=n.val();if(/^\d$/.test(i)&&i!=="0")return n.val("0"+i+" / ")},o=function(t){var n,r;if(t.meta)return;n=e(t.currentTarget),r=n.val();if(t.which!==8)return;if(n.prop("selectionStart")!=null&&n.prop("selectionStart")!==r.length)return;if(/\s\/\s?\d?$/.test(r))return t.preventDefault(),n.val(r.replace(/\s\/\s?\d?$/,""))},g=function(e){var t;return e.metaKey||e.ctrlKey?!0:e.which===32?!1:e.which===0?!0:e.which<33?!0:(t=String.fromCharCode(e.which),!!/[\d\s]/.test(t))},v=function(n){var r,i,s,o;r=e(n.currentTarget),s=String.fromCharCode(n.which);if(!/^\d+$/.test(s))return;if(c(r))return;return o=(r.val()+s).replace(/\D/g,""),i=t(o),i?o.length<=i.length[i.length.length-1]:o.length<=16},m=function(t){var n,r,i;n=e(t.currentTarget),r=String.fromCharCode(t.which);if(!/^\d+$/.test(r))return;if(c(n))return;i=n.val()+r,i=i.replace(/\D/g,"");if(i.length>6)return!1},d=function(t){var n,r,i;n=e(t.currentTarget),r=String.fromCharCode(t.which);if(!/^\d+$/.test(r))return;return i=n.val()+r,i.length<=4},y=function(t){var n,i,s,o,u;n=e(t.currentTarget),u=n.val(),o=e.payment.cardType(u)||"unknown";if(!n.hasClass(o))return i=function(){var e,t,n;n=[];for(e=0,t=r.length;e<t;e++)s=r[e],n.push(s.type);return n}(),n.removeClass("unknown"),n.removeClass(i.join(" ")),n.addClass(o),n.toggleClass("identified",o!=="unknown"),n.trigger("payment.cardType",o)},e.payment.fn.formatCardCVC=function(){return this.payment("restrictNumeric"),this.on("keypress",d),this},e.payment.fn.formatCardExpiry=function(){return this.payment("restrictNumeric"),this.on("keypress",m),this.on("keypress",a),this.on("keypress",l),this.on("keypress",f),this.on("keydown",o),this},e.payment.fn.formatCardNumber=function(){return this.payment("restrictNumeric"),this.on("keypress",v),this.on("keypress",u),this.on("keydown",s),this.on("keyup",y),this.on("paste",p),this},e.payment.fn.restrictNumeric=function(){return this.on("keypress",g),this},e.payment.fn.cardExpiryVal=function(){return e.payment.cardExpiryVal(e(this).val())},e.payment.cardExpiryVal=function(e){var t,n,r,i;return e=e.replace(/\s/g,""),i=e.split("/",2),t=i[0],r=i[1],(r!=null?r.length:void 0)===2&&/^\d+$/.test(r)&&(n=(new Date).getFullYear(),n=n.toString().slice(0,2),r=n+r),t=parseInt(t,10),r=parseInt(r,10),{month:t,year:r}},e.payment.validateCardNumber=function(e){var n,r;return e=(e+"").replace(/\s+|-/g,""),/^\d+$/.test(e)?(n=t(e),n?(r=e.length,w.call(n.length,r)>=0)&&(n.luhn===!1||h(e)):!1):!1},e.payment.validateCardExpiry=function(t,n){var r,i,s,o;return typeof t=="object"&&"month"in t&&(o=t,t=o.month,n=o.year),!t||!n?!1:(t=e.trim(t),n=e.trim(n),/^\d+$/.test(t)?/^\d+$/.test(n)?parseInt(t,10)<=12?(n.length===2&&(s=(new Date).getFullYear(),s=s.toString().slice(0,2),n=s+n),i=new Date(n,t),r=new Date,i.setMonth(i.getMonth()-1),i.setMonth(i.getMonth()+1,1),i>r):!1:!1:!1)},e.payment.validateCardCVC=function(t,r){var i,s;return t=e.trim(t),/^\d+$/.test(t)?r?(i=t.length,w.call((s=n(r))!=null?s.cvcLength:void 0,i)>=0):t.length>=3&&t.length<=4:!1},e.payment.cardType=function(e){var n;return e?((n=t(e))!=null?n.type:void 0)||null:null},e.payment.formatCardNumber=function(e){var n,r,i,s;return n=t(e),n?(i=n.length[n.length.length-1],e=e.replace(/\D/g,""),e=e.slice(0,+i+1||9e9),n.format.global?(s=e.match(n.format))!=null?s.join(" "):void 0:(r=n.format.exec(e),r!=null&&r.shift(),r!=null?r.join(" "):void 0)):e}}.call(this),function(e){var t=e.fn.ready;e.fn.ready=function(n){this.context===undefined?t(n):this.selector?t(e.proxy(function(){e(this.selector,this.context).each(n)},this)):t(e.proxy(function(){e(this).each(n)},this))}}(jQuery),$(function(){$.externalScript("https://js.stripe.com/v1/").done(function(e,t){$("input.credit-card-number").payment("formatCardNumber"),$("input.cvv").payment("formatCardCVC"),Stripe.setPublishableKey($('meta[name="stripe-key"]').attr("content"));var n={setupForm:function(){return $("form.signup_form").submit(function(e){return $("input[type=submit]").prop("disabled",!0).val("Processing..."),$("#credit_card_number").length?(n.processCard(),!1):!0})},processCard:function(){console.log("processing");var e;return e={name:$(".first-name").val()+" "+$(".last-name").val(),number:$("#credit_card_number").val(),cvc:$("#cvv").val(),expMonth:$("#_expiry_date_2i").val(),expYear:$("#_expiry_date_1i").val()},Stripe.createToken(e,n.handleStripeResponse)},handleStripeResponse:function(e,t){if(e!==200)return console.log("stripe error"),$("#stripe-error").fadeIn("fast").text(t.error.message).show(),$("input[type=submit]").prop("disabled",!1).val("Sign up");console.log("RESPONSE"),console.log(t),$("#victory_purchase_stripe_token").val(t.id),$("form.signup_form")[0].submit()}};return n.setupForm()})});