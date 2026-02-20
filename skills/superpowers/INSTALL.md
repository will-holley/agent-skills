# Install `obra/superpowers`

Use these commands to install [obra/superpowers](https://github.com/obra/superpowers):

```bash
tmp_dir="$(mktemp -d)"
git clone https://github.com/obra/superpowers "${tmp_dir}/superpowers"
mkdir -p "${HOME}/.claude/skills"
cp -R "${tmp_dir}/superpowers/"* "${HOME}/.claude/skills/"
rm -rf "${tmp_dir}"
```
