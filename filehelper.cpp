#include "filehelper.h"


FileHelper::FileHelper()
{

}

int FileHelper::rename_file(const QString &old, const QString &new_name)
{

}

QStringList FileHelper::get_all_files(const QString &path)
{
    QDir dir(path);
    QStringList list = dir.entryList(QDir::Files | QDir::NoSymLinks | QDir::NoDotAndDotDot, QDir::Time);
    return list;


}

QStringList FileHelper::get_all_files_md5s(const QString &path)
{
    m_md5_files.clear();
    QDir dir(path);
    QStringList list = dir.entryList(QDir::Files | QDir::NoSymLinks | QDir::NoDotAndDotDot, QDir::Time);
    QStringList md5s;
    Q_FOREACH(QString file, list) {
        QString md5 =                 fileChecksum(path + file, QCryptographicHash::Md5);

        md5s << md5;
        m_md5_files[md5] = path + file;
    }
    m_md5s = md5s;
    md5sChanged(md5s);
    return md5s;
}

int FileHelper::set_file_name_by_md5(const QString &md5, const QString &new_name)
{
    QString path_file = m_md5_files[md5];
    if (fileChecksum(path_file, QCryptographicHash::Md5) == md5) {

        bool status = QFile::rename(path_file, new_name);
        if (status) return 0;
    }
    return -1;

}

QString FileHelper::file_path_by_md5(const QString &md5)
{
    QString path_file = m_md5_files[md5];
    return path_file;
}

// Returns empty QByteArray() on failure.
QByteArray FileHelper::fileChecksum(const QString &fileName,
                        QCryptographicHash::Algorithm hashAlgorithm)
{
    QFile f(fileName);
    if (f.open(QFile::ReadOnly)) {
        QCryptographicHash hash(hashAlgorithm);
        if (hash.addData(&f)) {
            return hash.result().toHex();
        }
    }
    return QByteArray();
}
