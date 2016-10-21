function openWin(f,n,w,h,s){
	sb = s == "1" ? "1" : "0";
	l = (screen.width - w)/2;
	t = (screen.height - h)/2;
	if(!w) {
		sFeatures = "fullscreen=yes,center=1,scrollbars=1,status=0,directories=0,channelmode=0";
	} else {
		sFeatures = "left="+ l +",top="+ t +",height="+ h +",width="+ w
		+ ",center=1,scrollbars=" + sb + ",status=0,directories=0,channelmode=0,alwaysRaised=yes";
	}
	openwin = window.open(f , n , sFeatures );
}