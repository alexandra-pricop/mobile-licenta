
### Setup Git hooks
In order to prepend the branch name to your commit message, please copy the file `prepare-commit-msg` to your git folder `.git/hooks/` and make the file executable.

For example having the branch named `TEST-99` and running:
`git commit -m "Fixed bug"`
will result with commit message: `[TEST-99] Fixed bug`

### Setup Jenkins
Prerequisites:

1. Code signing set to manual + Tremend Team

2. `mcs-ci@tremend.ro` has access to the repo

3. App added on AppCenter

Go to https://mcsbuild.tremend.ro.

On the left, access `New Item`, scroll down to `Copy from` and type in `ios-mvvm-boilerplate`.

Once created go to the `Configure` page and follow the steps below:

1. Update `Repository URL` in the `Source Code Management` section

2. In the `Build` section, change:
   
    - `APP_IDENTIFIER`
   
    - `PROJECT_NAME`
   
    - `APPCENTER_APP_ID`

NOTE: For the current fastlane setup, you need to have a group named `Public` on AppCenter. 

If you want, you can change that in the `fastfile` by editing appcenter_upload destinations.

To start a build, access `Build with Parameters` and choose the desired branch from the list.

### Build environments

If you want to create other build environments you can follow [this](https://www.freecodecamp.org/news/managing-different-environments-and-configurations-for-ios-projects-7970327dd9c9/) tutorial or open `how_to_create_new_build_environments.pdf`.  


** Note: **  
In Jenkins, for `BUILD_CONFIGURATION` parameter you should set the exact name as your build schemas.