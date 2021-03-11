using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Google.Cloud.Firestore;

namespace SmartTraveller
{
    [FirestoreData]
    public class Bus
    {
        [FirestoreProperty]
        public string lat { get; set; }
        [FirestoreProperty]
        public string lon { get; set; }
        [FirestoreProperty]
        public int passengers { get; set; }

        [FirestoreProperty]
        public string[] onbus { get; set; }

        [FirestoreProperty]
        public string gps { get; set; }

        [FirestoreProperty]
        public string speed { get; set; }
        
        


    }
}
