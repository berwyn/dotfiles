# name: idan
# Display the following bits on the left:
# * Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# * Current directory name
# * Git branch and dirty state (if inside a git repo)

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l cwd_color (set_color -o "5653B8")
  set -l git_clean_color (set_color -o "262626")
  set -l git_dirty_color (set_color -o "AFAED5")
  set -l normal (set_color normal)
  set fish_color_command "005E85"
  set fish_color_param "005DAB"

  set -l cwd $cwd_color(prompt_pwd)

  # output the prompt, left to right

  # Add a newline before prompts
  echo -e ""

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  end

  # Display the current directory name
  echo -n -s $cwd $normal


  # Show git branch and dirty state
  if [ (_git_branch_name) ]
    set -l git_branch '(' (_git_branch_name) ')'

    if [ (_is_git_dirty) ]
      set git_info $git_dirty_color $git_branch "★"
    else
      set git_info $git_clean_color $git_branch
    end
    echo -n -s ' -> ' $git_info $normal
  end

  # Terminate with a nice prompt char
  echo -n -s ' $ ' $normal

end
