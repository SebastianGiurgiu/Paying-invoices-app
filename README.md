# Paying-invoices-app

Aplicatie pentru platirea taxelor sau duplicare lor

Scenariu la prima utilizare : 
  - se completeaza campul NrOfCompanies cu 24
  - se completeaza campul NrOfCompanies cu 48
  - se completeaza campul NrOfCompanies cu 50
  - se apasa butonul "Continue using new Data" 

  - se face swpite left pe una dintre facturile afisate pe ecran si vor aparea 2 optiuni : Duplicate si Paid
  
  - se apasa pe Duplicate dupa care se poate observa ca factura a fost duplicata ( facturile duplicate vor avea background galben)
  - se face swipe left din nou si acum se apasa pe Paid 
  - se face o reanjare a taxelor in functie de mai multi termeni 
  - putem folosi bara de search pentru a cauta factura platita
  
  
Despre utlizarea aplicatiei : 
  - exista optiunea de swipe left si in momentul cand facem search 
  - daca declanseam o actiune Duplicate sau Paid in momentul de search se va sterge textul si vom reveni la afisarea tuturor taxelor
  - dupa prima utilizare datale vor si salvate in CoreData deci la urmatoarele utlizari se pot folosi apasand butonul "Continue using data from database"
  - **ATENTIE** : daca oricare camp nu e completat si se va apasa butonul "Continue using new Data"  aplicatia va crapa
  - in orice moment in care ne aflam in ecranul cu facturi putem sa ne intoarcem in pagina principala si sa decidem cu ce data continuam
  
