# CheckerLabSD

Mod de utilizare:

 * Pentru a verifica un anumit laborator, trebuie ca variabila de mediu
_LabSD_ sa fie setata cu numarul laboratorului.
 * Pentru a verifica toate cerintele laboratorului, se poate rula script-ul
fara niciun argument: <b>./check.sh</b>
 * Pentru a verifica task-ul X (cerinta obligatorie a laboratorului), script-ul
se ruleaza specificand flag-ul _-t_ urmat de numarul task-ului: <b>./check.sh -t X</b>
 * Pentru a verifica bonusul Y (cerinta optionala a laboratorului), script-ul
se ruleaza specificand flag-ul _-b_ urmat de numarul bonusului: <b>./check.sh -b Y</b>

Mentiuni:

* Script-ul se bazeaza pe faptul ca majoritatea cerintelor de laborator
vor putea fi verificate prin intermediul unor rezultate trecute intr-un
fisier de iesire. Rezulta ca pentru a verifica daca un task este rezolvat
corect, rezultatul va trebui scris in fisier.

    Exemple de cerinte care pot fi verificate de script:
        ..* Adaugarea elementelor intr-un resizable array / lista inlantuita /
            alta structura de date
        ..* Pargurgeri pe grafuri / arbori

    Exemple de cerinte care nu pot fi verificate la fel de usor:
        ..* Cerinte de tip "Implementati un constructor / metoda"
        ..* Cerinte de tip "Demonstrati functionarea clasei / metodei printr-un
            cod simplist"
        ..* Utilizare valgrind pentru verificare absenta memory leaks

    Posibila solutie: pentru categoriile de cerinte care presupun
        setarea unor anumiti membri ai clasei, scheletul de laborator
        ar putea veni cu o metoda _toString()_ deja implementata
        (overload <<) pentru a furniza un format fix de specificare
        al obiectului.

* In <b>Out/LabX</b> studentii scriu in fisierul corespunzator unui anumit task
rezultatele obtinute.

* In <b>Ref/LabX</b> responsabilii de laborator trec output-ul asteptat pentru
fiecare dintre cerintele laboratorului.

* Atat punctajele pentru task-urile obligatorii cat si cele pentru bonusuri
sunt pastrate de script in array-uri specifice fiecarui laborator. Array-urile
sunt usor configurabile, urmand formatul

    _(punctaj_task1 .. punctaj_taskX punctaj_bonus1 .. punctaj_bonusY)_
