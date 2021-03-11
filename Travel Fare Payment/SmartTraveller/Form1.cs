using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Google.Cloud.Firestore;

using FireSharp.Config;
using FireSharp.Interfaces;
using FireSharp.Response;
using System.Threading;
using System.Diagnostics;

namespace SmartTraveller
{
    public partial class Form1 : Form
    {
        FirestoreDb database;

        IFirebaseConfig config = new FirebaseConfig
        {
            AuthSecret = "EkRQFiywuicBhDcfq6TJrrZU3M94GUNuavdne6nk",
            BasePath = "https://smart-traveller-302307-default-rtdb.firebaseio.com/",
        };

        IFirebaseClient client;
        public Form1()
        {
            InitializeComponent();
            client = new FireSharp.FirebaseClient(config);


            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            lblAuthenticate.Text = "Authenticate";
            pnlIdentifyPassenger.Hide();
            pnlSuccess.Hide();
            pnlNoCredit.Hide();
            pnlLogin.Show();
            pnlAlert.Hide();
            pnlNotValid.Hide();
            pnlThank.Hide();
            txtLogin.Focus();
            String path = AppDomain.CurrentDomain.BaseDirectory + @"smart-traveller.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            database = FirestoreDb.Create("smart-traveller-302307");


        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        public static string gps;
        async void checkBus()
        {
            try
            {
                CollectionReference usersRef = database.Collection("bus");
                Query query = usersRef.WhereEqualTo("rfid", txtLogin.Text);
                QuerySnapshot snapshot = await query.GetSnapshotAsync();
                foreach (DocumentSnapshot document in snapshot.Documents)
                {

                    StaticClass.bus = document.Id;
                    StaticClass.busRfid = txtLogin.Text;
                    bus = true;
                    break;
                }


                if (bus == false)
                {
                    txtLogin.Clear();
                    lblAuthenticate.Text = "Authenticate";
                    txtLogin.Focus();

                }
                else
                {

                    DocumentReference busdoc = database.Collection("bus").Document(StaticClass.bus);
                    DocumentSnapshot snapshot2 = await busdoc.GetSnapshotAsync();

                    if (snapshot2.Exists)
                    {
                        Bus bus = snapshot2.ConvertTo<Bus>();
                        gps = bus.gps;
                    }
                    Thread thr = new Thread(new ThreadStart(a));
                    thr.Start();

                    pnlIdentifyPassenger.Show();
                    pnlLogin.Hide();
                    txtPassengerId.Focus();
                }

            }
            catch (Exception)
            {

            }

        }

        bool bus = false;
        private void txtLogin_TextChanged(object sender, EventArgs e)
        {
            if (bus == false)
            {
                if (txtLogin.Text.Length == 10)
                {
                    lblAuthenticate.Text = "Connecting ...";
                    checkBus();
                }

            }
        }

        private void txtPassengerId_TextChanged(object sender, EventArgs e)
        {
            if (txtPassengerId.Text == StaticClass.busRfid)
            {
                //this.Close();
                Process.Start("shutdown", "/s /t 0");

            }
            else
            {
                if (txtPassengerId.Text.Length == 10)
                {
                    checkPassenger();
                }

            }
        }

        bool passOnBus = false;
        async void checkPassenger()
        {

            string pasid = "0";
            string travel = "";
            string slat = "";
            string slon = "";
            string buslat = "";
            string buslon = "";

            CollectionReference passRef = database.Collection("passenger");
            Query query = passRef.WhereEqualTo("rfid", txtPassengerId.Text);
            QuerySnapshot snapshot3 = await query.GetSnapshotAsync();
            foreach (DocumentSnapshot document in snapshot3.Documents)
            {

                pasid = document.Id;
                Passenger pa = document.ConvertTo<Passenger>();
                travel = pa.travelling;
                slat = pa.slat;
                slon = pa.slon;

                break;

            }

            if (travel.Equals("No") || travel.Equals(StaticClass.bus))
            {

                DocumentReference passdoc = database.Collection("passenger").Document(pasid);
                DocumentSnapshot snapshot1 = await passdoc.GetSnapshotAsync();

                if (snapshot1.Exists)
                {
                    Passenger pass = snapshot1.ConvertTo<Passenger>();
                    int credit = pass.credits;

                    DocumentReference busdoc = database.Collection("bus").Document(StaticClass.bus);
                    DocumentSnapshot snapshot = await busdoc.GetSnapshotAsync();

                    if (snapshot.Exists)
                    {
                        Bus bus = snapshot.ConvertTo<Bus>();
                        passOnBus = false;
                        buslat = bus.lat;
                        buslon = bus.lon;

                        for (int a = 0; a < bus.onbus.Length; a++)
                        {
                            if (bus.onbus[0] == txtPassengerId.Text)
                            {
                                passOnBus = true;
                                break;
                            }
                        }

                        if (passOnBus == false)
                        {
                            if (credit >= 30)
                            {
                                await busdoc.UpdateAsync("onbus", FieldValue.ArrayUnion(txtPassengerId.Text));
                                await busdoc.UpdateAsync("passengers", FieldValue.Increment(1));
                                //await passdoc.UpdateAsync("credits", FieldValue.Increment(-10));
                                await passdoc.UpdateAsync("travelling", StaticClass.bus);
                                await passdoc.UpdateAsync("slat", buslat);
                                await passdoc.UpdateAsync("slon", buslon);
                                pnlIdentifyPassenger.Hide();
                                pnlSuccess.Show();
                                txtPassengerId.Clear();
                                await Task.Delay(1000);
                                txtPassengerId.Focus();
                                pnlSuccess.Hide();
                                pnlIdentifyPassenger.Show();
                            }
                            else
                            {
                                pnlIdentifyPassenger.Hide();
                                pnlNoCredit.Show();
                                txtPassengerId.Clear();
                                await Task.Delay(1000);
                                txtPassengerId.Focus();
                                pnlNoCredit.Hide();
                                pnlIdentifyPassenger.Show();
                            }
                        }
                        else
                        {
                            double price;
                            double dis = distance(slat, slon, buslat, buslon, 'K');
                            if (dis <= 2)
                            {
                                price = 10.00;
                            }
                            else
                            {
                                price = 10.00 + ((dis - 2)*2.00);
                            }

                            decimal fee = Math.Round((decimal)price, 2);
                            price = (double)(fee * -1);
                            
                            await busdoc.UpdateAsync("onbus", FieldValue.ArrayRemove(txtPassengerId.Text));
                            await busdoc.UpdateAsync("passengers", FieldValue.Increment(-1));
                            await passdoc.UpdateAsync("credits", FieldValue.Increment(price));
                            await passdoc.UpdateAsync("travelling", "No");

                            pnlIdentifyPassenger.Hide();
                            pnlThank.Show();
                            txtPassengerId.Clear();
                            await Task.Delay(1000);
                            txtPassengerId.Focus();
                            pnlThank.Hide();
                            pnlIdentifyPassenger.Show();
                        }


                    }


                }
                
            }
            else
            {
                if (pasid == "0")
                {
                    pnlIdentifyPassenger.Hide();
                    pnlNotValid.Show();
                    
                    txtPassengerId.Clear();
                    await Task.Delay(1000);
                    txtPassengerId.Focus();
                    pnlNotValid.Hide();
                    pnlIdentifyPassenger.Show();
                }
                else
                {
                    DocumentReference passdoc = database.Collection("passenger").Document(pasid);
                    await passdoc.UpdateAsync("credits", FieldValue.Increment(-30));
                    pnlIdentifyPassenger.Hide();
                    pnlAlert.Show();
                    
                    txtPassengerId.Clear();
                    await Task.Delay(1000);
                    txtPassengerId.Focus();
                    pnlAlert.Hide();
                    pnlIdentifyPassenger.Show();

                }
                

            }










        }

        async void a()
        {
            float speed;
            string lat;
            string longi;
            string stspeed;
            FirebaseResponse response = await client.GetTaskAsync("bus/" + gps);
            Data obj = response.ResultAs<Data>();

            speed = obj.Speed;
            lat = obj.latitude;
            longi = obj.longitude;
            if (speed == 0)
            {
                stspeed = "0.0000";
            }
            else
            {
                stspeed = speed.ToString();
            }
            //speed = speed.Substring(0, 4);

            DocumentReference busdoc = database.Collection("bus").Document(StaticClass.bus);
            await busdoc.UpdateAsync("speed", stspeed);
            await busdoc.UpdateAsync("lat", lat);
            await busdoc.UpdateAsync("lon", longi);

            await Task.Delay(1000);

            a();

        }

        
        private double distance(string slat, string slon, string elat, string elon, char unit)
        {
            double lat1 = double.Parse(slat);
            double lon1 = double.Parse(slon);
            double lat2 = double.Parse(elat);
            double lon2 = double.Parse(elon);
            if ((lat1 == lat2) && (lon1 == lon2))
            {
                return 0;
            }
            else
            {
                double theta = lon1 - lon2;
                double dist = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta));
                dist = Math.Acos(dist);
                dist = rad2deg(dist);
                dist = dist * 60 * 1.1515;
                if (unit == 'K')
                {
                    dist = dist * 1.609344;
                }
                else if (unit == 'N')
                {
                    dist = dist * 0.8684;
                }
                return (dist);
            }
        }

        private double deg2rad(double deg)
        {
            return (deg * Math.PI / 180.0);
        }

        
        private double rad2deg(double rad)
        {
            return (rad / Math.PI * 180.0);
        }

        private void lblAuthenticate_Click(object sender, EventArgs e)
        {

        }
    }
}
