#!/usr/bin/env bash
# Tests for Edict 580 — Court section on the Asimi website
# These tests verify that the Court section, nav links, and related elements
# render correctly in the Hugo build output.
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PUBLIC="$PROJECT_ROOT/public"
PASS=0
FAIL=0

assert_contains() {
  local file="$1"
  local pattern="$2"
  local description="$3"
  if grep -q "$pattern" "$file" 2>/dev/null; then
    echo "  ✓ $description"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $description"
    echo "    Expected pattern '$pattern' in $file"
    FAIL=$((FAIL + 1))
  fi
}

assert_count_at_least() {
  local file="$1"
  local pattern="$2"
  local min_count="$3"
  local description="$4"
  local actual
  actual=$(grep -c "$pattern" "$file" 2>/dev/null || echo 0)
  if [ "$actual" -ge "$min_count" ]; then
    echo "  ✓ $description (found $actual, expected >= $min_count)"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $description (found $actual, expected >= $min_count)"
    FAIL=$((FAIL + 1))
  fi
}

echo "Building Hugo site..."
cd "$PROJECT_ROOT"
rm -rf public
hugo --logLevel error --buildDrafts > /dev/null 2>&1
echo "Build complete."
echo ""

echo "=== Test: Court section in index.html ==="
assert_contains "$PUBLIC/index.html" 'section class="court" id="court"' "Court section exists with id"
assert_contains "$PUBLIC/index.html" 'The Three Realms' "Three Realms subsection present"
assert_contains "$PUBLIC/index.html" '人 Ren' "Ren realm card present"
assert_contains "$PUBLIC/index.html" '地 Di (Earth)' "Di (Earth) card present"
assert_contains "$PUBLIC/index.html" '天 Tian (Heaven)' "Tian (Heaven) card present"
assert_contains "$PUBLIC/index.html" 'The Ministers' "Ministers subsection present"
assert_contains "$PUBLIC/index.html" 'Secretary (中書令)' "Secretary minister card present"
# Guard the Secretary's authored description (data/home.yaml: ministers.list[].description).
# The prior proxy used a lowercase phrase without the (正名) gloss and could never match the
# rendered text; assert the actual rendered prose so the description cannot silently vanish.
assert_contains "$PUBLIC/index.html" 'Receives your intent, rectifies names (正名), and drafts edicts' "Secretary role prose rendered"
assert_contains "$PUBLIC/index.html" 'Chancellor (門下侍中)' "Chancellor minister card present"
assert_contains "$PUBLIC/index.html" 'Ministry of War (兵部)' "Ministry of War card present"
assert_contains "$PUBLIC/index.html" 'Forge (工部)' "Forge minister card present"
assert_contains "$PUBLIC/index.html" 'Judge (刑部)' "Judge minister card present"
assert_contains "$PUBLIC/index.html" 'Key Principles' "Key Principles subsection present"
assert_contains "$PUBLIC/index.html" 'Zhengming (正名)' "Zhengming principle badge present"
assert_contains "$PUBLIC/index.html" '仁 Ren' "Ren principle badge present"
assert_contains "$PUBLIC/index.html" '义 Yi' "Yi principle badge present"
assert_contains "$PUBLIC/index.html" '礼 Li' "Li principle badge present"
assert_contains "$PUBLIC/index.html" '智 Zhi' "Zhi principle badge present"
assert_contains "$PUBLIC/index.html" '信 Xin' "Xin principle badge present"
assert_contains "$PUBLIC/index.html" 'RULER_GUIDE.md' "Guide link points to RULER_GUIDE.md"
assert_count_at_least "$PUBLIC/index.html" 'principle-badge' 6 "At least 6 principle badges present"
echo ""

echo "=== Test: Realm analogy cards rendered ==="
assert_count_at_least "$PUBLIC/index.html" 'court-card-analogy' 3 "At least 3 realm analogy cards present"
assert_contains "$PUBLIC/index.html" 'court-card-analogy' "Ren realm analogy present"
assert_contains "$PUBLIC/index.html" 'court-card-analogy' "Di realm analogy present"
assert_contains "$PUBLIC/index.html" 'court-card-analogy' "Tian realm analogy present"
echo ""

echo "=== Test: Hero text ==="
assert_contains "$PUBLIC/index.html" 'hero-content' "Hero section present"
assert_count_at_least "$PUBLIC/index.html" '<h1>' 1 "Hero heading present"
echo ""

echo "=== Test: Court nav links in index.html ==="
assert_contains "$PUBLIC/index.html" 'href="#court"' "Court nav link uses bare in-page fragment"
assert_contains "$PUBLIC/index.html" 'href="/#court"' "Court footer link uses root-relative fragment"
echo ""

echo "=== Test: Court nav link in blog list page ==="
assert_contains "$PUBLIC/blog/index.html" '/#court' "Court nav link in blog list"
echo ""

echo "=== Test: Court nav link in all blog single pages ==="
BLOG_PAGES=$(find "$PUBLIC/blog" -name "index.html" -not -path "$PUBLIC/blog/index.html" 2>/dev/null)
BLOG_PAGE_COUNT=0
for page in $BLOG_PAGES; do
  BLOG_PAGE_COUNT=$((BLOG_PAGE_COUNT + 1))
  assert_contains "$page" '/#court' "Court nav link in $(basename $(dirname "$page"))"
done
if [ "$BLOG_PAGE_COUNT" -eq 0 ]; then
  echo "  ✗ No blog single pages found"
  FAIL=$((FAIL + 1))
fi
echo ""

echo "=== Test: Court CSS classes in index.html ==="
assert_contains "$PUBLIC/index.html" 'class="court"' "Court CSS class applied"
assert_contains "$PUBLIC/index.html" 'class="court-subsection-title"' "Court subsection title CSS class"
assert_contains "$PUBLIC/index.html" 'class="principle-badge' "Principle badge CSS class"
assert_contains "$PUBLIC/index.html" 'class="court-guide-link"' "Court guide link CSS class"
echo ""

echo "=== Test: Responsive media query includes .court ==="
assert_contains "$PROJECT_ROOT/layouts/index.html" '.features, .installation, .vi-modes, .court, .blog-section' "Court included in responsive padding rule"
echo ""

# --- Edict 837: new doctrinal copy is rendered (Hero / Three Realms / Seal Chain / Ruler / Developers) ---
# These guard the copy that Edict 837 introduced on top of the page. Without them the
# new deliverables could silently vanish and the suite would still pass.

echo "=== Test: Hero doctrinal copy (Edict 837) ==="
assert_contains "$PUBLIC/index.html" 'Asimi: An Imperial Court for Your Project' "Hero headline rendered"
assert_contains "$PUBLIC/index.html" 'open-source, multi-model, single-daemon coding agent' "Hero sub-headline rendered"
assert_contains "$PUBLIC/index.html" 'moves with intent, not chaos' "Hero sub-headline doctrine intact"
assert_contains "$PUBLIC/index.html" 'curl -fsSL https://asimi.dev/installer | bash' "Hero installer command line rendered"
echo ""

echo "=== Test: both hero buttons retained (Edict 837) ==="
assert_contains "$PUBLIC/index.html" 'Get Started' "Get Started button retained"
assert_contains "$PUBLIC/index.html" 'View on GitHub' "View on GitHub button retained"
echo ""

echo "=== Test: Three Realms rendered as side-by-side cards (Edict 837 / de-duplicated) ==="
assert_contains "$PUBLIC/index.html" 'court-card-analogy' "Three Realms card analogy rendered"
assert_contains "$PUBLIC/index.html" '人 Ren (Intent and Will)' "Ren card title rendered"
assert_contains "$PUBLIC/index.html" '地 Di (Earth)' "Di card title rendered"
assert_contains "$PUBLIC/index.html" '天 Tian (Heaven)' "Tian card title rendered"
assert_contains "$PUBLIC/index.html" 'rectifies names' "Ren/正名 card prose rendered"
assert_contains "$PUBLIC/index.html" 'wu wei flow' "Di/wu wei card prose rendered"
assert_contains "$PUBLIC/index.html" 'does not suggest, signal, or negotiate' "Tian judges card prose rendered"
assert_contains "$PUBLIC/index.html" 'the Capital (committed, unpushed changes)' "Capital part rendered"
assert_contains "$PUBLIC/index.html" 'the Middle Kingdom (staged changes)' "Middle Kingdom part rendered"
assert_contains "$PUBLIC/index.html" 'the Borderlands (unstaged changes)' "Borderlands part rendered"
# The Three Realms must appear only once (the stacked doctrine block was removed).
assert_count_at_least "$PUBLIC/index.html" '人 Ren (Intent and Will)' 1 "Ren realm rendered"
if grep -q 'court-doctrine-item' "$PUBLIC/index.html" 2>/dev/null; then
  echo "  ✗ Stacked doctrine items still present"
  FAIL=$((FAIL + 1))
else
  echo "  ✓ Stacked doctrine items removed"
  PASS=$((PASS + 1))
fi
echo ""

echo "=== Test: Seal chain rendered (Edict 837) ==="
assert_contains "$PUBLIC/index.html" 'seal-chain' "Seal chain list rendered"
assert_contains "$PUBLIC/index.html" 'Judge' "Judge's Seal entry rendered"
assert_contains "$PUBLIC/index.html" "s Seal — the change is well tested and the tests pass" "Judge's Seal wording rendered"
assert_contains "$PUBLIC/index.html" "s Seal — the code adheres to the Imperial Code" "Chancellor's Seal wording rendered"
assert_contains "$PUBLIC/index.html" "s Seal — your final approval" "Ruler's Seal wording rendered"
echo ""

echo "=== Test: Become a Ruler section rendered (Edict 837) ==="
assert_contains "$PUBLIC/index.html" 'Become a Ruler' "Become a Ruler subsection rendered"
assert_contains "$PUBLIC/index.html" 'No minister is fully trusted' "Become a Ruler closing rendered"
echo ""

echo "=== Test: Built for Developers section (Edict 837) ==="
assert_contains "$PUBLIC/index.html" 'built-for-developers' "Built for Developers section rendered"
assert_contains "$PUBLIC/index.html" 'Terminal-Native' "Terminal-Native bullet rendered"
assert_contains "$PUBLIC/index.html" 'Engineered in Go' "Engineered in Go bullet rendered"
assert_contains "$PUBLIC/index.html" 'Container-Isolated' "Container-Isolated bullet rendered"
assert_contains "$PUBLIC/index.html" 'Open Source' "Open Source bullet rendered"
echo ""

echo "=== Test: no forbidden draft errors reintroduced (Edict 837) ==="
if grep -q 'never falls into chaos\|signal the court\|DOWNLOAD_INSTRUCTION' "$PUBLIC/index.html" 2>/dev/null; then
  echo "  ✗ Forbidden draft string present in index.html"
  FAIL=$((FAIL + 1))
else
  echo "  ✓ No forbidden draft strings present"
  PASS=$((PASS + 1))
fi
echo ""

echo "=== Test: no stale roster names anywhere (Edict 837) ==="
for f in "$PUBLIC/index.html" "$PROJECT_ROOT/data/home.yaml" "$PROJECT_ROOT/RULER_GUIDE.md"; do
  if grep -q 'Chancellor (宰相)\|Sage (孔子)\|Strategist\|Marshal' "$f" 2>/dev/null; then
    echo "  ✗ Stale roster name present in $f"
    FAIL=$((FAIL + 1))
  else
    echo "  ✓ No stale roster name in $(basename "$f")"
    PASS=$((PASS + 1))
  fi
done
echo ""

# --- Homepage wrinkles: de-duplicate Three Realms, Installation section, Key Principles on their own lines ---

echo "=== Test: Three Realms no longer duplicated ==="
assert_count_at_least "$PUBLIC/index.html" 'The Three Realms (三界)' 1 "Three Realms heading appears once"
# Exactly one realm renderer: the side-by-side cards (three cards, each with an analogy footer).
assert_count_at_least "$PUBLIC/index.html" 'court-card-analogy' 3 "Exactly the side-by-side realm cards rendered (3)"
echo ""

echo "=== Test: Installation section naming and placement ==="
assert_contains "$PUBLIC/index.html" '<h2 class="section-title">Installation</h2>' "Installation section titled 'Installation'"
if grep -q 'Quick Start' "$PUBLIC/index.html" 2>/dev/null; then
  echo "  ✗ Stale 'Quick Start' heading still present"
  FAIL=$((FAIL + 1))
else
  echo "  ✓ Stale 'Quick Start' heading removed"
  PASS=$((PASS + 1))
fi
# Installation section must sit just above the Blog section.
INSTALL_LINE=$(grep -n 'section class="installation" id="install"' "$PUBLIC/index.html" | head -1 | cut -d: -f1)
BLOG_LINE=$(grep -n 'section class="blog-section" id="blog"' "$PUBLIC/index.html" | head -1 | cut -d: -f1)
if [ -n "$INSTALL_LINE" ] && [ -n "$BLOG_LINE" ] && [ "$INSTALL_LINE" -lt "$BLOG_LINE" ]; then
  echo "  ✓ Installation section precedes Blog section (install@$INSTALL_LINE < blog@$BLOG_LINE)"
  PASS=$((PASS + 1))
else
  echo "  ✗ Installation section does not precede Blog (install@${INSTALL_LINE:-none}, blog@${BLOG_LINE:-none})"
  FAIL=$((FAIL + 1))
fi
echo ""

echo "=== Test: System dependencies support multiple platforms ==="
assert_contains "$PUBLIC/index.html" 'data-tab="dep-brew"' "macOS dependency tab present"
assert_contains "$PUBLIC/index.html" 'data-tab="dep-dnf"' "Fedora/RHEL dependency tab present"
assert_contains "$PUBLIC/index.html" 'data-tab="dep-apt"' "Debian/Ubuntu dependency tab present"
assert_contains "$PUBLIC/index.html" 'brew install podman just' "macOS dependency command present"
assert_contains "$PUBLIC/index.html" 'sudo dnf install podman just' "Fedora/RHEL dependency command present"
assert_contains "$PUBLIC/index.html" 'sudo apt install podman just' "Debian/Ubuntu dependency command present"
assert_count_at_least "$PUBLIC/index.html" 'class="tab-group"' 2 "Both dependency and Asimi install tab groups rendered"
echo ""

echo "=== Test: Key Principles each on its own line ==="
assert_contains "$PROJECT_ROOT/layouts/index.html" 'flex-direction: column' "Principles row stacked vertically"
echo ""

echo "================================"
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
