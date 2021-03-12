using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Google.Cloud.Firestore;

namespace SmartTraveller
{
    [FirestoreData]
    class Passenger
    {
        [FirestoreProperty]
        public int credits { get; set; }
        [FirestoreProperty]
        public String travelling { get; set; }
        [FirestoreProperty]
        public String slat { get; set; }
        [FirestoreProperty]
        public String slon { get; set; }


    }
}
