import java.util.ArrayList;
import java.util.List;

PImage slika;
Snow[] flakes = new Snow[300];
//lista pitanja
ArrayList<Pitanje> listaPitanja = new ArrayList();
ArrayList<Pitanje> listaTocnihPitanja = new ArrayList();
int indeksPitanja = 0;
  int tocnoOdg;
int h =0;
ArrayList<Pitanje> pomocnaLista = new ArrayList();
String[] lista;
final int pregled=3;
final int unosRezultata=4;
final int spremanjeRezultata=5;
long mil = millis();
long s = 0, min =0;
//status programa, opcije:
final int uTijeku=0;
final int kraj=1;
final int odgovorenoPitanje=2;
//trenutni status označvam varijablom status
int status = uTijeku;

String ime = "";
int najmanjiRez = 0;
int vrijeme;
int cekaj = 1500;
boolean otkucaj = false;
//sva pitanja spremim u polje
 String[] poljePitanja = {"Kada počinje godišnje doba zima?", "21.12.", "21.3.","21.6.","23.9.", "Koliko stranica ima geometrijski lik pravokutnik?","2","3","4","5",
                           "Koji je glavni grad Hrvatske?", "Split", "Osijek", "Zadar", "Zagreb", "Kako se zove naše lijepo plavo more?", "Jonsko", "Talijansko", "Baltičko", "Jadransko",
                           "Čudnovate zgode šegrta hlapića napisao/napisala je:", "August Šenoa","Ivana Brlić-Mažuranić", "Dobriša Cesarić", "Marko Marulić",
                           "Grad ne ušću rijeke Cetine je:", "Omiš","Split", "Šibenik","Makarska",
                           "Navijači Hajduka nazivaju se: ", "Bad Blude Boysi", "Kohorta",  "Torcida", "Funcuti",
                           "Sport koji se igra na ledu nazivamo:", "Nogomoet", "Košarka", "Plivanje", "Hokej",
                           "Za koju životinju kažemo da je čovjekov vjerni prijatelj?", "Krokodil","Pas","Lav","Zlatna ribica",
                           "Izbaci uljeza! Što od navedenog nije padalina?", "Sijeg", "Kiša", "Mraz", "Sunce",
                           "Koje navedeno voće NE raste na stablu: ", "Lubenica", "Kruška","Jabuka", "Breskva",
                           "Grad u Istri je: ", "Dubrovnik", "Pula","Osijek","Rab",
                           "Koliko 1 sat ima minuta?","30","40","50","60",
                           "U jednadzbi 2x=16, x iznosi:", "4","6","8","10",
                           "Prijevod za 'Good morning' glasi: ", "Dobro jutro!", "Dobar dan.", "Dobra večer.", "Laku noć...",
                           "Koja navedena životinja živi u moru:", "žaba", "dupin","ptica","mrav",
                           "Prve piramide izgrađe su u:", "Irskoj","Španjolskoj", "Egiptu", "Kini", 
                           "Što od naveenog nije marka automobila: ", "BMW", "Nokia", "Audi", "Mazda",
                           "Geometrijski lik je trokut, a njemu slično geometrijsko tijelo je: ", "Kocka","Valjak","Kvadar","Piramida",
                           "Izbaci uljeza među nebeskim tijelima!", "Zvijezda", "Oblak", "Sunce", "Mjesec",
                           "Taj_Mahal.jpg","Kina", "Indija", "Jordan", "Rusija",
                           "petra.jpeg", "Oman", "Maroko", "Jordan", "Egipat",
                           "reynisfjara.jpg", "Finska", "Island", "Norvešla", "Kanada",
                           "Saint_Basil's.jpg", "Ukrajina", "Bugarska", "Grčka", "Rusija",
                           "sirena.jpeg", "Danska", "Švedska", "Nizozemska", "Belgija",
                           "zastavaIrana.jpg", "Palestina", "Irak", "Iran", "Indija",
                           "zastavaFinske.png", "Grčka", "Švedska", "Estonija", "Finska",
                           "zastavaIndije.png", "Indija", "Mongolija", "Vietnam", "Tajland",
                           "zastavaIslanda.png", "Norveška", "Island", "Danska", "Latvija"
                          };
  int[] tocniOdgovori={1,3,4,4,2,1,3,4,2,4,1,2,4,3,1,2,3,2,4,2,2,3,2,4,1,3,4,1,2};

void setup(){
  size(800,500);
  vrijeme = millis();
  tocnoOdg=0;
  for (int i = 0; i<flakes.length; i++) { 
    flakes[i] = new Snow(random(2, 10));
    flakes[i].spreadY(i);
  }
  
  int i2=0;
    for (int i=0; i<poljePitanja.length; i+=5)
    {
      Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 30);
      pomocnaLista.add(trenutnoPitanje);
      i2++;
    }
   //za shuffle arrayliste
   // Collections.shuffle(listaPitanja);
   
   while(listaPitanja.size()< 10)
   {
     int indeks = (int)random(pomocnaLista.size());
     listaPitanja.add(pomocnaLista.get(indeks));
     pomocnaLista.remove(indeks);
   }
    
    
}

void draw() {
  background(12, 27, 99);
  for (int i = 0; i < flakes.length; i++) {
    flakes[i] .display();
  if (flakes[i].x > 280 && flakes[i].y >445 && flakes[i].x<400){
    flakes[i].bounce();  
  }
  }
  
  int brojTocnihPitanja = listaTocnihPitanja.size();
   int ukupnoPitanja= listaPitanja.size();
    mil = millis();

  if(mil >= 1000) {
    s = mil /1000;
    mil -= s*1000;
  }
  if(s >= 60) {
    min = s/60;
    s-= min * 60;
  }
  switch(status) {
    case uTijeku:
    textSize(18);
  text("Proteklo vrijeme:   " + min + " : "+ s + " : "+mil, 550, 30);
  
      textSize(18);
      int trenutnoPitanje = indeksPitanja+1;
      text("Pitanje: " + trenutnoPitanje +"/" + ukupnoPitanja,30,30);
      listaPitanja.get(indeksPitanja).display();
      break;
    case odgovorenoPitanje:
      textSize(18);
      text("Proteklo vrijeme:   " + min + " : "+ s + " : "+mil, 550, 30);
  
      
      //ako je tocno ----- inače ----
      if(listaPitanja.get(indeksPitanja).check(key))
      {
       fill(255,255,255);
       textSize(20);
       listaTocnihPitanja.add(listaPitanja.get(indeksPitanja));
       text("TOČAN ODGOVOR!", 100,50);
      h=1;
      }
      else
      {
        h=0;
        fill(255,255,255);
        textSize(20);
        text("NETOČAN ODGOVOR!", 100,50);
      }
       if(millis()-vrijeme>=cekaj)
      {
      status = uTijeku;
      indeksPitanja++;
      otkucaj = true;
      vrijeme = millis();
      if(h==1) tocnoOdg++;
      }
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
       break;
    case kraj:
      noLoop();
      text("Vrijeme potrebno za rješavanje: " + min +" minuta, "+s+" sekundi i "+ mil+ " milisekundi", 100,50);
      fill(39,185,208);
      textSize(18);
      text("Kviz je završio.Vaš rezultat je "+tocnoOdg+"/"+ukupnoPitanja+".", 100, 100);
      text("Kliknite R za ponovo igranje",100,150);
      text("Kliknite L za pregled najboljih rezultata", 100,175);
      break;
     
    case pregled:
      String[] lines = loadStrings("list.txt");
         String [] nova = {};
         for (int i = 0 ; i < lines.length; i++) 
         {
           nova = append(nova, lines[i]);
         }
         
        fill(39,185,208);
        textSize(18);
        text("Top rezultati:", 50, 100);
        for(int i = 0; i < nova.length; ++i)
        text(nova[i], 100, 120 + i*20);
        
        String najmanjiRezStr = nova[2].substring(nova[2].indexOf(" ")+1);
         najmanjiRez = Integer.parseInt(najmanjiRezStr);
        if(tocnoOdg > najmanjiRez)
        {
          text("Kliknite U ako želite unijeti svoj rezultat", 100, 250);
        }
        
        break;
     
     case unosRezultata:
        fill(39,185,208);
        textSize(18);
        text("Unesi ime:", 100, 100);
        
        break;
     
     case spremanjeRezultata:
         String[] linije = loadStrings("list.txt");
         String [] novaLista = {};
         for (int i = 0 ; i < linije.length; i++) 
         {
           novaLista = append(novaLista, linije[i]);
         }
         
         String rez1s = novaLista[0].substring(novaLista[0].indexOf(" ")+1);
         String rez2s = novaLista[1].substring(novaLista[1].indexOf(" ")+1);
         //String rez3s = novaLista[2].substring(novaLista[2].indexOf(" ")+1);
         // treci najbolji nit ne trebamo jer nebi mogli nit doć do ovog inače(nema pritiska Q u situaciji kada bi se trebao unijeti novi rezultat
         
         int rez1 = Integer.parseInt(rez1s);
         int rez2 = Integer.parseInt(rez2s);
         //int rez3 = Integer.parseInt(rez3s);
         
         String s1, s2, s3;
         if(tocnoOdg >= rez1)
         {
            s1 = ime + " " + tocnoOdg;
            s2 = novaLista[0];
            s3 = novaLista[1];
         }
         
         else if(tocnoOdg >= rez2)
         {
            s1 = novaLista[0];
            s2 = ime + " " + tocnoOdg;         
            s3 = novaLista[1];
           
         }
         
         else
         {
            s1 = novaLista[0];
            s2 = novaLista[1];
            s3 = ime + " " + tocnoOdg;         
           
         }
         
         String[] spremnaLista = {};
         spremnaLista = append(spremnaLista, s1);
         spremnaLista = append(spremnaLista, s2);
         spremnaLista = append(spremnaLista, s3);
         
         
        fill(39,185,208);
        textSize(18);
        text("Top rezultati:", 50, 100);
        for(int i = 0; i < novaLista.length; ++i)
        text(novaLista[i], 100, 120 + i*20);
        
        saveStrings("data/list.txt", spremnaLista);
        exit();
       
         break;
      
  }
}

void keyPressed()
{
  switch(status) {
    case uTijeku:
      if(key>='1' && key <='4')
      {
        status = odgovorenoPitanje;
        vrijeme = millis();
      }
      break;
    case odgovorenoPitanje:
      status = uTijeku;
     // indeksPitanja++;
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
      
      break;
     case kraj:
       if(key=='r') {
         loop();
         indeksPitanja=0;
         status=uTijeku;
         tocnoOdg=0;
         int i2=0;
         
        pomocnaLista= new ArrayList();
        listaPitanja= new ArrayList();
        for (int i=0; i<poljePitanja.length; i+=5)
        {
          Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 30);
          pomocnaLista.add(trenutnoPitanje);
          i2++;
          }

        while(listaPitanja.size()< 3)
        {
         int indeks = (int)random(pomocnaLista.size());
         listaPitanja.add(pomocnaLista.get(indeks));
         pomocnaLista.remove(indeks);
        }
       }
       if(key == 'l'){
         status = pregled;
         loop();
       }
       break;
       
     case pregled:
       loop();
       if(key=='u' && (tocnoOdg > najmanjiRez)){
         loop();
         status = unosRezultata;
       }
       break;
     
     case unosRezultata:
       if(key==ENTER) {
         status = spremanjeRezultata;
         loop();
       }
       else 
       {
         if(key >= 'a' && key <= 'z')
         ime+=key;
       }
       break;
     default:
       break;  
  }
  
}

class Pitanje {
  String tekstPitanja;
  String odg1, odg2, odg3, odg4;
  int tocanOdgovor;
  int pozicijaX, pozicijaY;

  
  Pitanje(String tp, String o1, String o2, String o3, String o4, int tocan, int x, int y)
  {
    tekstPitanja = tp;
    odg1 = o1;
    odg2 = o2;
    odg3 = o3;
    odg4 = o4;
    tocanOdgovor = tocan;
    pozicijaX = x;
    pozicijaY = y;
    tocnoOdg=0;
  }
  
  void display() {
    fill(255,255,255);
    lista = split(tekstPitanja, ".");
    //text(lista[0], pozicijaX, pozicijaY);
    if(lista.length == 2){
      textSize(20);
      //text("Pitanje: " + indeksPitanja+1 + "/10\n ", pozicijaX, pozicijaY);
      slika = loadImage(tekstPitanja);
      textSize(20);
      if(tekstPitanja.indexOf("zastava") != -1){
        text("Čija se zastava nalazi na slici?", pozicijaX, pozicijaY+25);
      }
      else{
        text("U kojoj se državi nalazi znamenitost sa slike?", pozicijaX, pozicijaY+25);
      }
      image(slika, pozicijaX, pozicijaY+50, 300,200);
      fill(255,255,255);
      //textSize(20);
      //text("Pitanje: "+ indeksPitanja+1 + "/10\n ", pozicijaX, pozicijaY);
      fill(255,255,255);
      textSize(16);
      text(" 1.) "+odg1, pozicijaX, pozicijaY + 275);
      text(" 2.) "+odg2, pozicijaX, pozicijaY + 300 );
      text(" 3.) "+odg3, pozicijaX, pozicijaY+325);
      text(" 4.) "+odg4, pozicijaX, pozicijaY + 350);
      fill(255,255,255);
      textSize(15);
      //text("Na tipkovnici odaberi broj uz točan odgovor.", pozicijaX, pozicijaY+360);
      text("Trenutno stanje bodova: " + tocnoOdg, pozicijaX, pozicijaY+375);
    }
    else{
      fill(255,255,255);
      textSize(20);
      text(tekstPitanja, pozicijaX, pozicijaY+30);
      fill(255,255,255);
      textSize(16);
      text(" 1) "+odg1, pozicijaX, pozicijaY+60);
      text(" 2) "+odg2, pozicijaX, pozicijaY+85);
      text(" 3) "+odg3, pozicijaX, pozicijaY+110);
      text(" 4) "+odg4, pozicijaX, pozicijaY+135);
      fill(255,255,255);
      textSize(13);
      text("Trenutno stanje bodova: " + tocnoOdg, pozicijaX, pozicijaY+170);
      //text("Na tipkovnici odaberi broj uz točan odgovor.", pozicijaX, pozicijaY+130);
  }
    //fill(255, 204, 102);
    //textSize(20);
    //text("Pitanje: "+ indeksPitanja+1 + "/10\n " + tekstPitanja, pozicijaX, pozicijaY);
    //fill(0, 26, 51);
    //textSize(16);
    //text(" 1) "+odg1, pozicijaX, pozicijaY+60);
    //text(" 2) "+odg2, pozicijaX, pozicijaY+85);
    //text(" 3) "+odg3, pozicijaX, pozicijaY+110);
    //text(" 4) "+odg4, pozicijaX, pozicijaY+135);
    //fill(0);
    textSize(15);
    // text("Na tipkovnici odaberi broj uz točan odgovor.", pozicijaX, pozicijaY+130);
  }
  
   boolean check(char keyToTest) {
    if(keyToTest=='1' && tocanOdgovor==1)  return true;
    if(keyToTest=='2' && tocanOdgovor==2)  return true; 
    if(keyToTest=='3' && tocanOdgovor==3)  return true; 
    if(keyToTest=='4' && tocanOdgovor==4)  return true; 
    return false;
  }
 
}

class Snow {
  float x; 
  float y;
  float alpha;
  float diameter;
  float speed = random(.1, .9);
  float descentX;

  Snow (float tempD) {
    x = random(-50, width+50);
    y = random(0,40);
    diameter = tempD;
  }
  
  void spreadY(int i) {
    y = y - i*3;
  }
  
  void display() {
    alpha = map(y, 0, height, 255, -50);
    noStroke();
    fill(255, alpha);
    ellipse(x, y, diameter, diameter);
    y = y + speed;
    x = x + descentX;
    
    //checking the boundary
    if (y > height) {
      y = -diameter;
    }
    if (x < 0-50) {
      x = width+diameter;} 
      else if (x > width+50){
      x = 0-diameter;
    }
    
    }
  void bounce(){
    y = y - speed; 
}
}
