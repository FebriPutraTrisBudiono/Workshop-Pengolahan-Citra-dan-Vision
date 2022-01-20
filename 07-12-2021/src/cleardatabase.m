fprintf(['>> Membersihkan database... ']);
delete database.mat

person = struct('Name', [], 'Age', [], 'FID1', [], 'FID2', []);
person = struct2table(person);

minutiae = struct('ID', [], 'X', [], 'Y', [], 'Type', []);
minutiae = struct2table(minutiae);

save database person minutiae

fprintf(['selesai!\n']);