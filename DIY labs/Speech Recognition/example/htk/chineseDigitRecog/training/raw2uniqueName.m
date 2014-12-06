function uniqueName=raw2uniqueName(rawName, parentDir, allParentDir)

index=findCellStr(allParentDir, parentDir);
fprintf(fid, '"*/%.5d-%s.lab"\r\n', index, raw(1:end-4));
