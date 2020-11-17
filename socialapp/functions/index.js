const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.takipGerceklesti = functions.firestore.document('followers/{takipEdilenId}/followersOfUser/{takipEdenKullaniciId}').onCreate(async (snapshot, context) => {
    const takipEdilenId = context.params.takipEdilenId;
    const takipEdenId = context.params.takipEdenKullaniciId;

    const postsSnapshot = await admin.firestore().collection("posts").doc(takipEdilenId).collection("postsOfUser").get();

    postsSnapshot.forEach((doc) => {
        if (doc.exists) {
            const postId = doc.id;
            const postData = doc.data();

            admin.firestore().collection("streams").doc(takipEdenId).collection("streamingPostsOfUser").doc(postId).set(postData);
        }
    });
});

exports.takiptenCikildi = functions.firestore.document('followers/{takipEdilenId}/followersOfUser/{takipEdenKullaniciId}').onDelete(async (snapshot, context) => {
    const takipEdilenId = context.params.takipEdilenId;
    const takipEdenId = context.params.takipEdenKullaniciId;

    const postsSnapshot = await admin.firestore().collection("streams").doc(takipEdenId).collection("streamingPostsOfUser").where("publishedId", "==", takipEdilenId).get();

    postsSnapshot.forEach((doc) => {
        if (doc.exists) {
            doc.ref.delete();
        }
    });
});

exports.yeniGonderiEklendi = functions.firestore.document('posts/{takipEdilenKullaniciId}/postsOfUser/{gonderiId}').onCreate(async (snapshot, context) => {
    const takipEdilenId = context.params.takipEdilenId;
    const gonderiId = context.params.gonderiId;
    const yeniGonderiData = snapshot.data();

    const takipcilerSnapshot = await admin.firestore().collection("followers").doc(takipEdilenId).collection("followersOfUser").get();
    takipcilerSnapshot.forEach(doc => {
        const takipciId = doc.id;
        admin.firestore().collection("streams").doc(takipciId).collection("streamingPostsOfUser").doc(postId).set(yeniGonderiData);
    });
});

exports.gonderiGuncellendi = functions.firestore.document('posts/{takipEdilenKullaniciId}/postsOfUser/{gonderiId}').onUpdate(async (snapshot, context) => {
    const takipEdilenId = context.params.takipEdilenId;
    const gonderiId = context.params.gonderiId;
    const guncellenmisGonderiData = snapshot.after.data();

    const takipcilerSnapshot = await admin.firestore().collection("followers").doc(takipEdilenId).collection("followersOfUser").get();
    takipcilerSnapshot.forEach(doc => {
        const takipciId = doc.id;
        admin.firestore().collection("streams").doc(takipciId).collection("streamingPostsOfUser").doc(postId).update(guncellenmisGonderiData);
    });
});

exports.gonderiSilindi = functions.firestore.document('posts/{takipEdilenKullaniciId}/postsOfUser/{gonderiId}').onUpdate(async (snapshot, context) => {
    const takipEdilenId = context.params.takipEdilenId;
    const gonderiId = context.params.gonderiId;

    const takipcilerSnapshot = await admin.firestore().collection("followers").doc(takipEdilenId).collection("followersOfUser").get();
    takipcilerSnapshot.forEach(doc => {
        const takipciId = doc.id;
        admin.firestore().collection("streams").doc(takipciId).collection("streamingPostsOfUser").doc(postId).delete();
    });
});

/*
exports.kayitSilindi = functions.firestore.document('deneme/{docId}').onDelete((snapshot, context) => {
    admin.firestore().collection("gunluk").add({
        "aciklama": "Deneme koleksiyonundan kayıt silindi",
    });
});

exports.kayitGüncellendi = functions.firestore.document('deneme/{docId}').onUpdate((change, context) => {
    admin.firestore().collection("gunluk").add({
        "aciklama": "Deneme koleksiyonunda kayıt güncellendi",
    });
});

exports.yazmaGerceklesti = functions.firestore.document('deneme/{docId}').onCreate((change, context) => {
    admin.firestore().collection("gunluk").add({
        "aciklama": "Deneme koleksiyonunda veri ekleme, güncelleme, silme işlemlerinden biri gerçekleşti",
    });
});
*/