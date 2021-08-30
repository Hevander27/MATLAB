%{
Input: Enter string for chemical formula
Output: Molecular weight
Algorithm:

%}

% Current bugs:
%   NH#O yields a result, when it should send usr back to input prompt

clc; clear

AminoAcids = {'O', 'C', 'N', 'S', 'H'; 15.9994, 12.011, 14.00674, 32.066, 1.00794};

NotLetter = 0; Letter = 0;
FormulaL = []; FormulaN = [];
Number = 0; CalMol = 0; Menu = true;
fprintf('Chapter 6 Homework, Amino Acids Formula Calculator\n\n');
disp(AminoAcids);
while Menu 
    fprintf('Enter a combination of chemical elements listed above \n');
    Error = 0;
    ChemForm = input('Enter Chemical Formula: ', 's'); ChemForm = upper(ChemForm);
    if InList(AminoAcids, ChemForm, 1) ~= 1
        disp('Improper value listed');
    else
        for n = 1:length(ChemForm)
            Check = NumberOrLetter(ChemForm, n);
            NotLetter = NotLetter + Check;
            if NotLetter == 0
                if InList(AminoAcids, ChemForm, n) ~= 1
                    disp('Improper value listed'); Error = 1; break;
                else
                    FormulaL = [FormulaL, ChemForm(n)];
                    Letter = Letter + 1;
                    if Letter == 2
                        FormulaN(end+1) = 1; disp(ChemForm(n));
                        Letter = 0;
                    end
                end
            elseif NotLetter > 0
                if Check ~= 1
                    if InList(AminoAcids, ChemForm, n) ~= 1
                        disp('Improper value listed'); Error = 1; break;
                    else
                        Prn = n-1;
                        Number = ChemForm(Prn - (NotLetter - 1));
                        for s = 2:NotLetter
                            Number = [Number, ChemForm(Prn - (NotLetter - s))];
                        end
                        Number = str2double(Number);
                        disp(ChemForm(n));
                        FormulaL = [FormulaL, ChemForm(n)];
                        FormulaN(end+1) = Number;
                        NotLetter = 0;
                        Letter = 1;
                    end
                end
            end
            if Letter == 1 && n == length(ChemForm) && NotLetter == 0
                FormulaN(end+1) = 1; disp(ChemForm(n));
            elseif NotLetter > 0 && n == length(ChemForm)
                Number = ChemForm(n - (NotLetter - 1));
                for s = 2:NotLetter
                    Number = [Number, ChemForm(n - (NotLetter - s))];
                end
                Number = str2double(Number);
                FormulaN(end+1) = Number; disp('End number');
                NotLetter = 0;
            end
        end
        if Error == 0
            Menu = false; CalMol = 1; disp('Calculate Molecule');
        else
            FormulaN = []; FormulaL = []; NotLetter = 0; Letter = 0;
        end
        if length(FormulaN) < length(FormulaL)
            FormulaN(end+1) = 1; disp('Safety');
        end
    end
end
if CalMol
    MolecularWeight(FormulaL, FormulaN);
end
