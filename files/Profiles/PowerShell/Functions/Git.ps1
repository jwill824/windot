## Git - These functions allow for management of Git Repositories
function Reset-AllRepositories() {
    $RepositoryDirectories = Get-AllRepositories
  
    foreach ($r in $RepositoryDirectories) {
      git init $r.FullName
    }
  }
  
function Get-AllRepositories() {
    return (Get-ChildItem $env:SOURCE_ROOT -Attributes Directory+Hidden -ErrorAction SilentlyContinue -Filter '.\.git' -Recurse).Parent
}

function Clear-RepositoryBranches() {
    $branches = git branch --list | Select-String -Pattern '^\*' -NotMatch | Select-String -Pattern 'main' -NotMatch

    foreach ($b in $Branches) {
        $Branch = $b.Line.Trim()
        git branch -D $Branch
    }
}