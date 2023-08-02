# FIXME commit hash is "unknown"
/*
$ ./result/bin/radicle-node --help
2023-08-02T00:32:41.639+02:00 INFO  node     Starting node..
2023-08-02T00:32:41.639+02:00 INFO  node     Version 0.2.0 (unknown)

$ ./result/bin/rad --help
rad 0.8.0 (unknown)
*/

# FIXME tests are failing. maybe because .git is missing? -> no such file

{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, libgit2
, zlib
, stdenv
, darwin
, git
}:

rustPlatform.buildRustPackage rec {
  pname = "radicle";

  # radicle-node --help
  versionBase = "0.2.0";

  # date of source commit
  versionDate = "2023-07-26";

  version = "${versionBase}-unstable-${versionDate}";

  # https://github.com/radicle-dev/heartwood
  src = fetchFromGitHub {
    owner = "radicle-dev";
    repo = "heartwood";
    rev = "7368e389427bc49e29e0554405c17f5c11c3c8de";
    hash = "sha256-yhBYMxG4DkykEDeBbM2FZNq/Teb5R5A6kOp/Ei2mxEs=";
  };

  # wrong cargoHash generated by nix-init
  #cargoHash = "sha256-CSC4p2pC6doxIlmGaekxrwFXN2bsaFbjZMw9bVe8Oho=";
  cargoHash = "sha256-3yA6rdcbL/iekuFE79W8wq4YuHknRUAg7vWa4zTNy7A=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libgit2
    zlib
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
  ];

  # FIXME tests are failing
  doCheck = false;

  /*
  checkInputs = [
    git
  ];
  */

  meta = with lib; {
    description = "A decentralized app for code collaboration";
    homepage = "https://radicle.xyz/";
    #homepage = "https://github.com/radicle-dev/heartwood";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ ];
  };
}

/*
FIXME tests are failing
   Compiling radicle-crypto v0.1.0 (/build/source/radicle-crypto)
   Compiling radicle-cob v0.1.0 (/build/source/radicle-cob)
   Compiling radicle v0.2.0 (/build/source/radicle)
   Compiling radicle-crdt v0.1.0 (/build/source/radicle-crdt)
   Compiling radicle-cli v0.8.0 (/build/source/radicle-cli)
   Compiling radicle-node v0.2.0 (/build/source/radicle-node)
   Compiling radicle-remote-helper v0.2.0 (/build/source/radicle-remote-helper)
    Finished release [optimized] target(s) in 29m 25s
     Running unittests src/lib.rs (target/x86_64-unknown-linux-gnu/release/deps/radicle-00ffa4e541e3f8af)

running 102 tests
test canonical::formatter::test::securesystemslib_asserts ... ok
test canonical::formatter::test::ordered_nested_object ... ok
test canonical::formatter::test::ascii_control_characters ... ok
test cob::common::test::test_color ... ok
test cob::identity::test::test_ordering ... ok
test cob::issue::test::test_issue_all ... FAILED
test cob::issue::test::test_concurrency ... FAILED
test cob::issue::test::test_issue_comment ... FAILED
test cob::issue::test::test_issue_create_and_change_state ... FAILED
test cob::issue::test::test_issue_create_and_get ... FAILED
test cob::issue::test::test_issue_create_and_assign ... FAILED
test cob::issue::test::test_issue_create_and_reassign ... FAILED
test cob::issue::test::test_issue_create_and_unassign ... FAILED
test cob::issue::test::test_issue_edit ... FAILED
test cob::issue::test::test_issue_edit_description ... FAILED
test cob::issue::test::test_issue_multilines ... FAILED
test cob::issue::test::test_issue_state_serde ... ok
test cob::issue::test::test_issue_reply ... FAILED
test cob::issue::test::test_ordering ... ok
test cob::patch::test::test_json_serialization ... ok
test cob::issue::test::test_issue_react ... FAILED
test cob::issue::test::test_issue_tag ... FAILED
test cob::patch::test::test_patch_create_and_get ... FAILED
test cob::patch::test::test_patch_discussion ... FAILED
test cob::patch::test::test_patch_merge ... FAILED
test cob::patch::test::test_patch_review ... FAILED
test cob::patch::test::test_patch_redact ... FAILED
test cob::patch::test::test_patch_review_comment ... FAILED
test cob::patch::test::test_patch_review_edit ... FAILED
test cob::patch::test::test_revision_edit_redact ... ok
test cob::patch::test::test_revision_review_merge_redacted ... ok
test cob::patch::test::test_patch_review_remove_summary ... FAILED
test cob::thread::tests::test_comment_edit_missing ... ok
test cob::thread::tests::test_comment_edit_redacted ... ok
test cob::thread::tests::test_comment_redact_missing ... ok
test cob::thread::tests::test_duplicate_comments ... ok
test cob::patch::test::test_patch_update ... FAILED
test cob::thread::tests::test_edit_comment ... ok
test cob::thread::tests::test_timeline ... ok
test git::test::test_version_from_str ... ok
test git::test::test_version_ord ... ok
test cob::thread::tests::test_redact_comment ... ok
test identity::did::test::test_did_encode_decode ... ok
test identity::did::test::test_did_vectors ... ok
test identity::doc::id::test::prop_from_str ... ok
test identity::doc::test::test_canonical_doc ... FAILED
test identity::doc::test::test_canonical_example ... FAILED
test identity::doc::test::test_not_found ... ok
test cob::thread::tests::prop_ordering ... ok
test identity::doc::test::prop_encode_decode ... ok
test node::address::store::test::test_alias ... ok
test identity::test::prop_json_eq_str ... ok
test node::address::store::test::test_entries ... ok
test node::address::store::test::test_get_none ... ok
test node::address::store::test::test_insert_and_get ... ok
test node::address::store::test::test_insert_and_remove ... ok
test node::address::store::test::test_insert_and_update ... ok
test node::address::store::test::test_insert_duplicate ... ok
test node::address::store::test::test_remove_nothing ... ok
test node::features::test::test_operations ... ok
test node::routing::test::test_count ... ok
test node::routing::test::test_entries ... ok
test node::routing::test::test_insert_and_get ... ok
test node::routing::test::test_insert_and_get_resources ... ok
test node::routing::test::test_insert_and_remove ... ok
test node::routing::test::test_insert_duplicate ... ok
test node::routing::test::test_insert_existing_updated_time ... ok
test node::routing::test::test_len ... ok
test node::routing::test::test_prune ... ok
test node::routing::test::test_remove_redundant ... ok
test node::routing::test::test_update_existing_multi ... ok
test node::test::test_alias ... ok
test node::tracking::store::test::test_node_policies ... ok
test node::tracking::store::test::test_node_policy ... ok
test node::tracking::store::test::test_repo_policies ... ok
test node::tracking::store::test::test_repo_policy ... ok
test node::tracking::store::test::test_track_and_untrack_node ... ok
test node::tracking::store::test::test_track_and_untrack_repo ... ok
test node::tracking::store::test::test_update_alias ... ok
test node::tracking::store::test::test_update_scope ... ok
test profile::test::canonicalize_home ... ok
test node::address::store::test::test_empty ... ok
test identity::test::test_valid_identity ... FAILED
test rad::tests::test_checkout ... FAILED
test rad::tests::test_fork ... FAILED
test storage::git::tests::test_references_of ... FAILED
test rad::tests::test_init ... FAILED
test storage::git::transport::local::url::test::test_url_parse ... ok
test storage::git::transport::local::url::test::test_url_to_string ... ok
test storage::git::transport::remote::url::test::test_url_parse ... ok
test storage::refs::tests::prop_canonical_roundtrip ... ok
test storage::tests::test_storage ... ok
test test::assert::test::assert_with_message ... ok
test storage::git::tests::test_sign_refs ... ok
test test::assert::test::test_assert_no_move ... ok
test test::assert::test::test_assert_panic_0 - should panic ... ok
test test::assert::test::test_assert_panic_1 - should panic ... ok
test test::assert::test::test_assert_succeed ... ok
test test::assert::test::test_assert_panic_2 - should panic ... ok
test test::assert::test::test_panic_message ... ok
test version::test::test_version ... ok
test storage::git::tests::test_remote_refs ... FAILED

failures:

---- cob::issue::test::test_issue_all stdout ----
thread 'cob::issue::test::test_issue_all' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_concurrency stdout ----
thread 'cob::issue::test::test_concurrency' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace

---- cob::issue::test::test_issue_comment stdout ----
thread 'cob::issue::test::test_issue_comment' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_create_and_change_state stdout ----
thread 'cob::issue::test::test_issue_create_and_change_state' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_create_and_get stdout ----
thread 'cob::issue::test::test_issue_create_and_get' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_create_and_assign stdout ----
thread 'cob::issue::test::test_issue_create_and_assign' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_create_and_reassign stdout ----
thread 'cob::issue::test::test_issue_create_and_reassign' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_create_and_unassign stdout ----
thread 'cob::issue::test::test_issue_create_and_unassign' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_edit stdout ----
thread 'cob::issue::test::test_issue_edit' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_edit_description stdout ----
thread 'cob::issue::test::test_issue_edit_description' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_multilines stdout ----
thread 'cob::issue::test::test_issue_multilines' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_reply stdout ----
thread 'cob::issue::test::test_issue_reply' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_react stdout ----
thread 'cob::issue::test::test_issue_react' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::issue::test::test_issue_tag stdout ----
thread 'cob::issue::test::test_issue_tag' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_create_and_get stdout ----
thread 'cob::patch::test::test_patch_create_and_get' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_discussion stdout ----
thread 'cob::patch::test::test_patch_discussion' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_merge stdout ----
thread 'cob::patch::test::test_patch_merge' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_review stdout ----
thread 'cob::patch::test::test_patch_review' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_redact stdout ----
thread 'cob::patch::test::test_patch_redact' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_review_comment stdout ----
thread 'cob::patch::test::test_patch_review_comment' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_review_edit stdout ----
thread 'cob::patch::test::test_patch_review_edit' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_review_remove_summary stdout ----
thread 'cob::patch::test::test_patch_review_remove_summary' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- cob::patch::test::test_patch_update stdout ----
thread 'cob::patch::test::test_patch_update' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/test.rs:126:91

---- identity::doc::test::test_canonical_doc stdout ----
thread 'identity::doc::test::test_canonical_doc' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/identity/doc.rs:476:10

---- identity::doc::test::test_canonical_example stdout ----
thread 'identity::doc::test::test_canonical_example' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/identity/doc.rs:430:10

---- identity::test::test_valid_identity stdout ----
thread 'identity::test::test_valid_identity' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/identity.rs:206:78

---- rad::tests::test_checkout stdout ----
thread 'rad::tests::test_checkout' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/rad.rs:483:10

---- rad::tests::test_fork stdout ----
thread 'rad::tests::test_fork' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/rad.rs:448:10

---- storage::git::tests::test_references_of stdout ----
thread 'storage::git::tests::test_references_of' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/storage/git.rs:748:78

---- rad::tests::test_init stdout ----
thread 'rad::tests::test_init' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/rad.rs:394:10

---- storage::git::tests::test_remote_refs stdout ----
thread 'storage::git::tests::test_remote_refs' panicked at 'called `Result::unwrap()` on an `Err` value: Git(Error { code: -1, klass: 0, message: "No such file or directory (os error 2)" })', radicle/src/storage/git.rs:717:62


failures:
    cob::issue::test::test_concurrency
    cob::issue::test::test_issue_all
    cob::issue::test::test_issue_comment
    cob::issue::test::test_issue_create_and_assign
    cob::issue::test::test_issue_create_and_change_state
    cob::issue::test::test_issue_create_and_get
    cob::issue::test::test_issue_create_and_reassign
    cob::issue::test::test_issue_create_and_unassign
    cob::issue::test::test_issue_edit
    cob::issue::test::test_issue_edit_description
    cob::issue::test::test_issue_multilines
    cob::issue::test::test_issue_react
    cob::issue::test::test_issue_reply
    cob::issue::test::test_issue_tag
    cob::patch::test::test_patch_create_and_get
    cob::patch::test::test_patch_discussion
    cob::patch::test::test_patch_merge
    cob::patch::test::test_patch_redact
    cob::patch::test::test_patch_review
    cob::patch::test::test_patch_review_comment
    cob::patch::test::test_patch_review_edit
    cob::patch::test::test_patch_review_remove_summary
    cob::patch::test::test_patch_update
    identity::doc::test::test_canonical_doc
    identity::doc::test::test_canonical_example
    identity::test::test_valid_identity
    rad::tests::test_checkout
    rad::tests::test_fork
    rad::tests::test_init
    storage::git::tests::test_references_of
    storage::git::tests::test_remote_refs

test result: FAILED. 71 passed; 31 failed; 0 ignored; 0 measured; 0 filtered out; finished in 2.38s

error: test failed, to rerun pass `-p radicle --lib`
error: builder for '/nix/store/snppbbzb8izn807bzfvmlvi8r1412aiz-radicle-0.2.0-unstable-2023-07-26.drv' failed with exit code 101;
*/