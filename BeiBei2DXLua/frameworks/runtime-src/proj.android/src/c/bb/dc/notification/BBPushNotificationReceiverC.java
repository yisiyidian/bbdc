package c.bb.dc.notification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class BBPushNotificationReceiverC extends BroadcastReceiver {
	@Override
	public void onReceive(Context context, Intent intent) {
		Intent service1 = new Intent(context, BBPushNotificationServiceC.class);
		context.startService(service1);
	}
}