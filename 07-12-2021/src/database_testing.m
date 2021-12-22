fprintf(['>> Membersihkan database... ']);
delete database_testing.mat

minutiae = struct('ID', [], 'X', [], 'Y', [], 'Type', [], 'Angle', [],'S1', [], 'S2', []);
minutiae = struct2table(minutiae);

save database_testing minutiae

fprintf(['selesai!\n']);