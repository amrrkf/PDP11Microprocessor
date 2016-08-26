/*
*
* solved by Ahmed Kamal
*/
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <iostream>
#include <sstream>
#include <cstring>
#include <vector>
#include <list>
#include <map>
#include <set>
#include <bitset>
#include <queue>
#include <utility>
#include <algorithm>
#include <functional>

using namespace std;

typedef long long int LL ;
#define vi vector<int>
#define ii pair<int,int>
#define vii vector< pair<int,int> >
#define sc(x) scanf("%d",&x)
double const EPS = 2.22045e-016;
#define INF (1<<29)

#define ALL(v)        ((v).begin()), ((v).end())
#define SZ(v)       ((int)((v).size()))
#define CLR(v, d)     memset(v, d, sizeof(v))
#define MP(x,y)       make_pair(x,y)

#define REP(i, n)   for(int i=0;i<(int)(n);++i)
#define LOOP(i,b,n)   for(int i=(b);i<(int)(n);++i)

#define PB  push_back
typedef vector<double>    VD;
typedef vector<string>    VS;
int gcd(int a, int b) { return (b == 0 ? a : gcd(b, a % b)); }

int oct_to_dec(string oc){
  int ans =0;
  reverse(ALL(oc));
  int p = 1;
  REP(i,SZ(oc)){
    ans += (oc[i]-'0')*p;
    p*=8;
  }
  return ans;
}

string oct_to_binary(string oc){
  map <char,string> to3;
  to3['0'] = "000";
  to3['1'] = "001";
  to3['2'] = "010";
  to3['3'] = "011";
  to3['4'] = "100";
  to3['5'] = "101";
  to3['6'] = "110";
  to3['7'] = "111";
  string ans;
  REP(i,SZ(oc)){
    ans+=to3[oc[i]] ;
  }
  return ans;
}

class ToRom{
  map<string,pair<int,string> > mp; // map from signal to position and label
  public:
    void  set_map(){

      // mp[""]   = MP(,"");

      // F1 4 bit at 8 -> 11
      mp["pcout"]     = MP(8,"0001");
      mp["mdrout"]    = MP(8,"0010");
      mp["zout"]      = MP(8,"0011");
      mp["rsrcout"]     = MP(8,"0100");
      mp["rdstout"]     = MP(8,"0101");
	  mp["spout"]     = MP(8,"0110");
      mp["srcout"] = MP(8,"1000");
      mp["dstout"] = MP(8,"1001");
      mp["tmpout"]   = MP(8,"1010");
      mp["addressout"]= MP(8,"1011");

      // F2 3 bit at 12 -> 14
      mp["pcin"]   = MP(12,"001");
      mp["irin"]   = MP(12,"010");
      mp["zin"]    = MP(12,"011");
      mp["rsrcin"]   = MP(12,"100");
      mp["rdstin"]   = MP(12,"101");
	  mp["spin"]   = MP(12,"110");
      
      // F3 2 bit  at 15 -> 16
      mp["marin"]   = MP(15,"01");
      mp["mdrin"]   = MP(15,"10");
      mp["tmpin"]  = MP(15,"11");

      // F4 2 bit at 17 -> 18
      mp["yin"]         = MP(17,"01");
      mp["srcin"]    = MP(17,"10");
      mp["dstin"]    = MP(17,"11");

      // F5 ALU are get in alu("data in binary")
      // 19-> 22

      //F6 2 bit 23 -> 24
      mp["rd"]    = MP(23,"01");
      mp["wr"]   = MP(23,"10");
      mp["hlt"]     = MP(23,"11");

      //f7 1 bit 25
      mp["cleary"]   = MP(25,"1");

      //f8 1 bit 26 "Carry"
      mp["setc"]   = MP(26,"1");

      //F9 1 bit 27 flag enable instead of WMFC
      //owrs
      mp["flags_e"]   = MP(27,"1");

      //F10 3bit 28->30
      mp["ordst"]       = MP(28,"001");
      mp["orindsrc"]    = MP(28,"010");
      mp["orinddst"]    = MP(28,"011");
      mp["orresult"]   = MP(28,"100");
      //owrs
      mp["or2op"]       = MP(28,"101");
	  mp["orop"]       = MP(28,"110");
	  mp["or1op"]       = MP(28,"111");

      //f11 PLA 1bit 31
      mp["plaout"]   = MP(31,"1");

    }
    string address , next_address ;
    string control_word;
    void main(){
      set_map();
      while(cin>>address){
          scanf(" : "); cin>>(next_address);
        getline(cin,control_word);
        scanf("\n");
        assign_word();
      }
    }

   // assign word for every line
    void assign_word(){
      int posArr[100]; CLR(posArr,0);
	  string add=oct_to_binary(next_address);
	  string uAR="";
	  for(int i=1;i<add.length();i++)
		uAR+=add[i];
      printf("%d\t=>\t\"%s",oct_to_dec(address) , uAR.c_str() );
     string word(32-8,'0');
     /*
      strtoc of control word
     */
      bool g = true;
      char * pch ;
      char *cw= new char [control_word.length()+1];;
      strcpy (cw, control_word.c_str());
      pch = strtok (cw," ,.-");
      while (pch != NULL)
      {
        // for evry control signal

        string sig(pch);
        string src = sig;
        REP(i,SZ(sig)){
          sig[i] = tolower(sig[i]);
        }
        //alu handling
        if(sig[0] =='a' && sig[1] == 'l' && sig[2] == 'u'){
          word[19-8] = sig[4];
          word[20-8] = sig[5];
          word[21-8] = sig[6];
          word[22-8] = sig[7];
            pch = strtok (NULL," ,.-");
          continue;
        }
        if(mp.find(sig) == mp.end()){
          printf("I cannot understand this word  (%s)\n",src.c_str() );
          g = false;
        }
        else if(posArr[ mp[sig].first ] != 0){
          printf("you write a signal from this function before in the same line  (%s)\n",src.c_str() );
          g = false;
        }
        else{
          string label = mp[sig].second;
          int start = mp[sig].first;

          LOOP(i,start - 8 , start - 8+SZ(label))
            word[i] = label[ i - start + 8];

          posArr[start] = 1;
        }
        pch = strtok (NULL," ,.-");
      }
      if(g)
        printf("%s\",\n",word.c_str() );
    }
};
int main()
{
  #ifndef ONLINE_JUDGE
      freopen("input.txt", "r", stdin);
      freopen("output.txt", "w", stdout);
  #endif
ToRom obj;
obj.main();
return 0;
}
