final foldersSnapshot = await tab
              .child("locationFolders")
              .ref
              .orderByChild("location")
              .equalTo(
                Locations.locations[reader(locationIndexProvider)],
              )
              .get();
          for (DataSnapshot folder in foldersSnapshot.children) {
            ref = folder.ref;
          }